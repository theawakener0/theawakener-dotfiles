return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        local logo = {
            [[██   ██ ███████ ███    ██  ██████  ██    ██ ██ ███    ███]],
            [[ ██ ██  ██      ████   ██ ██    ██ ██    ██ ██ ████  ████]],
            [[  ███   █████   ██ ██  ██ ██    ██ ██    ██ ██ ██ ████ ██]],
            [[ ██ ██  ██      ██  ██ ██ ██    ██  ██  ██  ██ ██  ██  ██]],
            [[██   ██ ███████ ██   ████  ██████    ████   ██ ██      ██]],
        }

        -- header
        dashboard.section.header.val = logo
        dashboard.section.header.opts = {
            position = "center",
            hl = "Type",
        }

        -- user/date/version line (centered)
        local user = vim.env.USER or vim.env.USERNAME or "User"
        local date = os.date("%A, %b %d")
        local v = vim.version()
        local ver = (v and string.format("%d.%d.%d", v.major, v.minor, v.patch)) or "n/a"
        local welcome = ("Welcome %s  •  %s  •  nvim %s"):format(user, date, ver)

        -- buttons (centered)
        dashboard.section.buttons.val = {
            dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
            dashboard.button("n", "  New file", ":ene <BAR> startinsert<CR>"),
            dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
            dashboard.button("t", "  Find text", ":Telescope live_grep<CR>"),
            dashboard.button("c", "  Config", ":e $MYVIMRC<CR>"),
            dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
        }
        dashboard.section.buttons.opts = {
            position = "center",
            spacing = 1,
        }

        -- footer (centered, small tip)
        dashboard.section.footer.val = {
            "",
            welcome,
            "",
            "Tip: Use the keys shown on the left to quickly run actions",
        }
        dashboard.section.footer.opts = {
            position = "center",
            hl = "Comment",
        }

        -- compute dynamic top padding to truly center vertically
        local function center_padding()
            local header_lines = #dashboard.section.header.val
            local button_lines = #dashboard.section.buttons.val
            local footer_lines = #dashboard.section.footer.val
            local total = header_lines + button_lines + footer_lines + 6 -- extra spacing between sections
            local win_lines = vim.o.lines
            local pad = math.floor((win_lines - total) / 2)
            if pad < 2 then pad = 2 end
            return pad
        end

        dashboard.opts.layout = {
            { type = "padding", val = center_padding() },
            dashboard.section.header,
            { type = "padding", val = 1 },
            dashboard.section.buttons,
            { type = "padding", val = 1 },
            dashboard.section.footer,
        }

        alpha.setup(dashboard.opts)
    end,
}
