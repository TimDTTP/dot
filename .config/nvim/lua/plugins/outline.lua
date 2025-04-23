return {
	"hedyhli/outline.nvim",
	config = function()
		-- Example mapping to toggle outline
		vim.keymap.set("n", "<leader>ol", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

		require("outline").setup({
			-- Your setup opts here (leave empty to use defaults)
			outline_window = {
				focus_on_open = false,
				show_cursorline = true,
				hide_cursor = true,
			},
			symbol_folding = {
				autofold_depth = false,
			},
		})
	end,
}
