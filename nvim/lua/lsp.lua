local M = {}

-- Compatibility shim: guard against plugins passing a function as bufnr
-- (seen with some nvim-cmp/cmp-nvim-lsp versions on Neovim 0.10+).
-- We wrap each LSP client's request method to coerce/normalize bufnr.
local function patch_client_request(client)
  if not client or client._request_patched or type(client.request) ~= 'function' then
    return
  end

  local orig = client.request
  client.request = function(self, method, params, handler, bufnr)
    -- If bufnr is accidentally a function (e.g. vim.api.nvim_get_current_buf), call it.
    if type(bufnr) == 'function' then
      local ok, n = pcall(bufnr)
      if ok and type(n) == 'number' then
        bufnr = n
      else
        bufnr = 0 -- fallback to current buffer
      end
    end

    -- If bufnr is missing or invalid, fallback to current buffer (0)
    if bufnr == nil or type(bufnr) ~= 'number' then
      bufnr = 0
    end

    return orig(self, method, params, handler, bufnr)
  end

  client._request_patched = true
end

-- Patch already-active clients on load
for _, c in ipairs(vim.lsp.get_active_clients and vim.lsp.get_active_clients() or vim.lsp.get_clients()) do
  patch_client_request(c)
end

-- Patch any future clients on attach
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('LspRequestBufnrPatch', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data and args.data.client_id or nil)
    if client then
      patch_client_request(client)
    end
  end,
})

-- single augroup for formatting on save
local lsp_format_group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = false })

-- Register diagnostic signs (better visibility)
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- capabilities helper (to be used by lsp-config)
M.capabilities = (function()
  local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  if ok then
    return cmp_nvim_lsp.default_capabilities()
  end
  return vim.lsp.protocol.make_client_capabilities()
end)()

M.on_attach = function(client, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  -- Your standard LSP keymaps
  map('n', 'gd', vim.lsp.buf.definition, 'LSP: Go to definition')
  map('n', 'K', vim.lsp.buf.hover, 'LSP: Hover')
  map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 'LSP: Code action')

  -- Format on save: prefer 'none-ls' when available, otherwise use any attached formatter
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = lsp_format_group, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = lsp_format_group,
      buffer = bufnr,
      callback = function()
        -- Check if 'none-ls' is present for this buffer's clients
        local prefer = nil
        local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
        if not clients then
          clients = vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = bufnr }) or {}
        end
        for _, c in ipairs(clients) do
          if c.name == "none-ls" or c.name == "null-ls" then
            prefer = "none-ls"
            break
          end
        end

        vim.lsp.buf.format({
          bufnr = bufnr,
          filter = function(format_client)
            if prefer then
              return format_client.name == prefer
            end
            return true
          end,
        })

          -- Global LSP bufnr normalizers for extra safety
          do
            local function coerce_bufnr(b)
              if type(b) == 'function' then
                local ok, n = pcall(b)
                if ok and type(n) == 'number' then
                  return n
                end
                return 0
              end
              if type(b) ~= 'number' then
                return 0
              end
              return b
            end

            -- Wrap vim.lsp.buf_request
            if type(vim.lsp.buf_request) == 'function' then
              local orig_buf_request = vim.lsp.buf_request
              vim.lsp.buf_request = function(bufnr, method, params, handler)
                return orig_buf_request(coerce_bufnr(bufnr), method, params, handler)
              end
            end

            -- Wrap vim.lsp.buf_request_all
            if type(vim.lsp.buf_request_all) == 'function' then
              local orig_buf_request_all = vim.lsp.buf_request_all
              vim.lsp.buf_request_all = function(bufnr, method, params)
                return orig_buf_request_all(coerce_bufnr(bufnr), method, params)
              end
            end
          end

      end,
    })
  end
end


return M
