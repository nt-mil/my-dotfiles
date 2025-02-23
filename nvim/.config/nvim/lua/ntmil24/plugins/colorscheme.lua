return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,

	config = function()
		local catppuccin = require("catppuccin")

		catppuccin.setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			transparent_background = true,
			term_colors = true,
			highlight_overrides = {
				mocha = function(C)
					return {
						NvimTreeNormal = { bg = C.none },
						CmpBorder = { fg = C.surface2 },
						Pmenu = { bg = C.none },
						NormalFloat = { bg = C.none },
						TelescopeBorder = { link = "FloatBorder" },
					}
				end,
			},
		})

		-- load the colorscheme here
		vim.cmd.colorscheme("catppuccin")
	end,
}
