require("core.keymaps") -- personal keymaps
require("core.options") -- general options preferences

-- set up Lazy package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

-- setup plugins
require("lazy").setup({
	require("plugins.autocomplete"),
	require("plugins.barbecue"),
	require("plugins.coderunner"),
	require("plugins.colorscheme"),
	require("plugins.conform"),
	require("plugins.flash"),
	require("plugins.gitsigns"),
	require("plugins.harpoon"),
	require("plugins.indentline"),
	require("plugins.lsp"),
	require("plugins.lualine"),
	require("plugins.markview"),
	require("plugins.misc"),
	require("plugins.noice"),
	require("plugins.oil"),
	require("plugins.outline"),
	require("plugins.smartcolumn"),
	require("plugins.smearcursor"),
	-- require("plugins.smoothscroll"),
	require("plugins.telescope"),
	require("plugins.toggleterm"),
	require("plugins.treesitter"),
	require("plugins.trouble"),
})

require("core.pluginmaps") -- personal keymaps revolving around plugins
