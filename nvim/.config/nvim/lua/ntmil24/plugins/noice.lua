return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		-- add any options here
	},
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		"rcarriga/nvim-notify",
	},
	config = function()
		local notify = require("notify")
		local noice = require("noice")

		notify.setup({ fps = 120, render = "compact", timeout = 500 })

		noice.setup({
			cmdline = {
				format = {
					search_and_replace = {
						kind = "replace",
						pattern = "^:%%?s/",
						icon = " ",
						lang = "regex",
					},
					search_and_replace_range = {
						kind = "replace",
						pattern = "^:'<,'>%%?s/",
						icon = " ",
						lang = "regex",
					},
				},
			},
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				long_message_to_split = true,
				lsp_doc_border = true,
			},
			throttle = 1000 / 120,
			routes = {
				{
					filter = { event = "msg_show", kind = "", find = "written" },
					opts = { skip = true },
				},
			},
			views = {
				cmdline_popup = {
					position = { row = vim.o.lines * 0.32, col = "50%" },
					size = { width = 60, height = "auto" },
				},
				popupmenu = {
					position = { row = vim.o.lines * 0.32 + 3, col = "50%" },
					size = { width = 60, height = 10 },
					border = { style = "rounded", padding = { 0, 1 } },
					win_options = {
						winhighlight = {
							Normal = "Normal",
							FloatBorder = "DiagnosticInfo",
						},
					},
				},
			},
		})
	end,
}
