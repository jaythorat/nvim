return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {--[[ things you want to change go here]]
	},

	config = function()
		require("toggleterm").setup({
			direction = "horizontal",
			persist_size = true,
			auto_scroll = true,
		})
		local keymap = vim.keymap

		keymap.set("n", "<leader>x", "<cmd>ToggleTerm<CR>", { desc = "Toggles Terminal." })
		--keymap.set("t", "<C-jk>", [[<C-\><C-n>]], { desc = "Shifts to normal mode from terminal mode" })
		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }

			keymap.set("t", "jk", [[<C-\><C-n>]], opts)
			keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
			keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
			keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
			keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
			keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
		end

		-- if you only want these mappings for toggle term use term://*toggleterm#* instead
		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
	end,
}
