return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		require("ibl").setup({
			indent = {
				char = "▏",
			},
			scope = {
				enabled = true,
				show_start = true,
				show_end = true,
				show_exact_scope = false,
				highlight = { "Function" },
			},
			exclude = {
				filetypes = {
					"help",
					"startify",
					"dashboard",
					"packer",
					"neogitstatus",
					"NvimTree",
					"Trouble",
				},
			},
		})
	end,
}
