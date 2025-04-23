-- Code runner
-- Runs code
vim.keymap.set("n", "<C-m>", vim.cmd.RunCode, { desc = "[M]ake file && runs code runner" })

-- Opens lazygit
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
	cmd = "lazygit",
	hidden = true,
	direction = "float",
	float_opts = {
		width = 170,
		height = 40,
	},
})

function _Lazygit_toggle()
	lazygit:toggle()
end

vim.api.nvim_set_keymap(
	"n",
	"<leader>tg",
	"<cmd>lua _Lazygit_toggle()<CR>",
	{ desc = "Opens lazygit", noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>tt",
	"<cmd>ToggleTerm<CR>",
	{ desc = "Opens floating terminal", noremap = true, silent = true }
)

-- Formats code
vim.api.nvim_create_user_command("Format", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })

vim.keymap.set("n", "<C-f>", "<cmd>Format<CR>", { desc = "Format code" })

-- Oil.nvim
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.api.nvim_set_keymap("n", "<leader>oi", "<cmd>lua require('oil').open_float('.')<CR>", {
	desc = "Opens floating Oil view",
	noremap = true,
	silent = true,
})

-- Harpoon
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end, { desc = "Appends file to Harpoon" })
vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Toggle Harpoon menu" })

vim.keymap.set("n", "<C-h>", function()
	harpoon:list():select(1)
end)
vim.keymap.set("n", "<C-j>", function()
	harpoon:list():select(2)
end)
vim.keymap.set("n", "<C-k>", function()
	harpoon:list():select(3)
end)
vim.keymap.set("n", "<C-l>", function()
	harpoon:list():select(4)
end)

-- Markview
vim.keymap.set("n", "<leader>mv", "<cmd>Markview toggle<CR>", {
	desc = "Toggle MarkView",
	noremap = true,
	silent = true,
})
