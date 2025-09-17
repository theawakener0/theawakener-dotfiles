return {
  'theawakener0/TraceBack',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    require('traceback').setup({
      ui = {
        picker = 'auto',
        undo_tree = {
            style = 'unicode',
            relative = true,
            show_depth = true,
        },
      },

      snapshot = {
        max_snapshots = 1000,
        throttle_ms = 5000,
      },
      lenses = {
        code = true,
        lsp = true,
        security = true,
        auto_render = true,
        debounce_ms = 120,
        event_debounce = {
          DiagnosticChanged = 80,
          TextChanged = 300,
          TextChangedI = 300,
          WinScrolled = 120,
          CursorHold = 0,
          InsertLeave = 80,
          BufEnter = 100,
          BufWinEnter = 100,
          LspAttach = 50,
        },
        max_annotations = 200,
        scan_window = 400,
        treesitter = true,
        lsp_max_per_line = 1,
        lsp_truncate = 120,
        lsp_show_codes = true,
        lsp_show_source = false,
        code_show_metrics = true,
        security_auto_render = true,
        security_context_analysis = true,
        security_smart_filtering = true,
      },

      keymaps = {
        timeline = '<Leader>tt',
        history = '<Leader>th',
        capture = '<Leader>tc',
        restore = '<Leader>tr',
        replay = '<Leader>tp',
        toggle_security = '<Leader>ts',
      },

      telescope = {
        enabled = true,
        theme = 'ivy',
        layout_config = { height = 0.4, preview_width = 0.6 },
      },
    })
  end,
}
