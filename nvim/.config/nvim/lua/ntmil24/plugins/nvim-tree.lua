return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- local HEIGHT_RATIO = 0.8
    local WIDTH_RATIO = 0.2 -- Default ratio (20% of screen width)
    local MIN_WIDTH = 20 -- Minimum width
    local MAX_WIDTH = 80 -- Maximum width
    local current_width = math.floor(vim.opt.columns:get() * WIDTH_RATIO)

    -- This makes sure the width starts at 20% of screen size but stays within a min/max limit
    local function get_tree_width()
      return math.max(MIN_WIDTH, math.min(current_width, MAX_WIDTH))
    end

		-- change color for arrows in tree to light blue
		vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
		vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

		-- configure nvim-tree
		nvimtree.setup({
			disable_netrw = true,
			hijack_netrw = true,
			respect_buf_cwd = true,
			sync_root_with_cwd = true,
			view = {
				relativenumber = true,
				-- float = {
				-- 	enable = true,
				-- 	open_win_config = function()
				-- 		local screen_w = vim.opt.columns:get()
				-- 		local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
				-- 		local window_w = screen_w * WIDTH_RATIO
				-- 		local window_h = screen_h * HEIGHT_RATIO
				-- 		local window_w_int = math.floor(window_w)
				-- 		local window_h_int = math.floor(window_h)
				-- 		local center_x = (screen_w - window_w) / 2
				-- 		local center_y = ((vim.opt.lines:get() - window_h) / 2)
				-- 		- vim.opt.cmdheight:get()
				-- 		return {
				-- 			border = "rounded",
				-- 			relative = "editor",
				-- 			row = center_y,
				-- 			col = center_x,
				-- 			width = window_w_int,
				-- 			height = window_h_int,
				-- 		}
				-- 	end,
				-- },
				-- width = function()
				-- 	return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
				-- end,
        width = get_tree_width,
			},
			-- change folder arrow icons
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when folder is closed
							arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},
			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
		})

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
		keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer

    keymap.set("n", "<M-h>", function()
      current_width = math.max(MIN_WIDTH, current_width - 5) -- Decrease width
      require("nvim-tree.view").resize(current_width)
    end, { desc = "Decrease file explorer width" }) -- Alt+h

    keymap.set("n", "<M-l>", function()
      current_width = math.min(MAX_WIDTH, current_width + 5) -- Increase width
      require("nvim-tree.view").resize(current_width)
    end, { desc = "Increase file explorer width" }) -- Alt+l


	end,
}
