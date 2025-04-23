return {
	"stevearc/oil.nvim",
	opts = {
		default_file_explorer = true,
		skip_confirm_for_simple_edits = true,
		-- show dot files, hide git files
		view_options = {
			show_hidden = true,
			natural_order = true,
			is_always_hidden = function(name, _)
				-- return name == ".." or name == ".git"
				return name == ".."
			end,
		},
		float = {
			max_width = 75,
			max_height = 30,
			preview_split = "below",
			win_options = {
				winblend = 15,
			},
		},
	},
	-- Optional dependencies
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
}
