return {
	"CRAG666/code_runner.nvim",
	opts = {
		mode = "toggleterm",
		before_run_filetype = function()
			vim.cmd.write()
		end,
		startinsert = true,
		float = {
			border = "rounded",
			blend = 15,
		},
		filetype = {
			cpp = "cd $dir && g++ -std=c++20 $fileName -o $fileNameWithoutExt && clear && $dir/$fileNameWithoutExt",
		},
	},
}
