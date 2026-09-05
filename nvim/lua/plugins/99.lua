return {
  "ThePrimeagen/99",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local _99 = require("99")
    local cwd = vim.uv.cwd()
    local basename = vim.fs.basename(cwd)

    _99.setup({
      model = "minimax-m2.5-free",
      logger = {
        level = _99.DEBUG,
        path = "/tmp/" .. basename .. ".99.debug",
        print_on_error = true,
      },
      tmp_dir = "./tmp",
      md_files = {
        "AGENT.md",
      },
      completion = {
        custom_rules = {
          "scratch/custom_rules/",
        },
        files = {
          enabled = true,
          max_file_size = 102400,
          max_files = 5000,
          exclude = { ".env", ".env.*", "node_modules", ".git" },
        },
        source = "native",
      },
      in_flight_options = {
        enable = true,
        throbber_opts = {},
        in_flight_interval = 1000,
      },
      display_errors = true,
      auto_add_skills = true,
    })

    vim.keymap.set("v", "<leader>9v", function()
      _99.visual()
    end, { desc = "99: Visual mode AI" })

    vim.keymap.set("n", "<leader>9x", function()
      _99.stop_all_requests()
    end, { desc = "99: Stop all requests" })

    vim.keymap.set("n", "<leader>9s", function()
      _99.search()
    end, { desc = "99: Search" })

    vim.keymap.set("n", "<leader>9o", function()
      _99.open()
    end, { desc = "99: Open last interaction" })

    vim.keymap.set("n", "<leader>9l", function()
      _99.view_logs()
    end, { desc = "99: View logs" })

    vim.keymap.set("n", "<leader>9c", function()
      _99.clear_previous_requests()
    end, { desc = "99: Clear previous requests" })

    vim.keymap.set("n", "<leader>9w", function()
      _99.Extensions.Worker.set_work()
    end, { desc = "99: Set work item" })

    vim.keymap.set("n", "<leader>9ws", function()
      _99.Extensions.Worker.search()
    end, { desc = "99: Search remaining work" })

    -- Vibe mode - AI code replacement
    vim.keymap.set("n", "<leader>9i", function()
      _99.vibe()
    end, { desc = "99: Vibe mode" })

    vim.keymap.set("v", "<leader>9i", function()
      _99.vibe()
    end, { desc = "99: Vibe mode (selection)" })

    -- Telescope integration for model and provider selection
    vim.keymap.set("n", "<leader>9m", function()
      require("99.extensions.telescope").select_model()
    end, { desc = "99: Select model" })

    vim.keymap.set("n", "<leader>9p", function()
      require("99.extensions.telescope").select_provider()
    end, { desc = "99: Select provider" })
  end,
}
