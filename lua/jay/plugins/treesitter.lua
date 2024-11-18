return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		-- import nvim-treesitter plugin
		local treesitter = require("nvim-treesitter.configs")

		-- configure treesitter
		treesitter.setup({ -- enable syntax highlighting
			highlight = {
				enable = true,
			},
			-- enable indentation
			indent = { enable = true },
			-- enable autotagging (w/ nvim-ts-autotag plugin)
			autotag = {
				enable = true,
			},
			-- ensure these language parsers are installed
			ensure_installed = {
				"json",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"markdown",
				"markdown_inline",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"query",
				"vimdoc",
				"c",
				"python",
				"sql",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
		-- Configure folding
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		vim.opt.foldlevel = 99 -- Start with all folds open
		vim.opt.foldenable = true

		-- Enhanced fold text
		vim.opt.foldtext =
			[[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]

		-- Optional: Set fillchars for a cleaner look
		vim.opt.fillchars = { fold = " " }

		-- Key mappings for folding
		local opts = { noremap = true, silent = true }
		vim.keymap.set("n", "za", "za", opts) -- Toggle fold under cursor
		vim.keymap.set("n", "zA", "zA", opts) -- Toggle all folds under cursor
		vim.keymap.set("n", "zR", "zR", opts) -- Open all folds
		vim.keymap.set("n", "zM", "zM", opts) -- Close all folds
		-- Additional useful mappings
		vim.keymap.set("n", "zj", "zjzz", opts) -- Move to next fold
		vim.keymap.set("n", "zk", "zkzz", opts)
	end,
}
