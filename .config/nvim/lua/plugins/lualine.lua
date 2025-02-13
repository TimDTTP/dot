local mode_width = 0
local branch_width = 0

return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local mode = {
			"mode",
			fmt = function(str)
				return " " .. str
				-- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
			end,
		}

		local filename = {
			"filename",
			file_status = true, -- displays file status (readonly status, modified status)
			path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
		}

		local hide_in_width = function()
			return vim.fn.winwidth(0) > 100
		end

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn" },
			symbols = { error = " ", warn = " ", info = " ", hint = " " },
			colored = false,
			update_in_insert = false,
			always_visible = false,
			cond = hide_in_width,
		}

		local diff = {
			"diff",
			colored = false,
			symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
			cond = hide_in_width,
		}

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto", -- Set theme based on environment variable
				-- Some useful glyphs:
				-- https://www.nerdfonts.com/cheat-sheet
				--        
				section_separators = { left = "", right = "" },
				component_separators = { left = " ", right = " " },
				disabled_filetypes = { "alpha", "neo-tree" },
				always_divide_middle = true,
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							if str == "" then
								mode_width = 0
								return ""
							end
							mode_width = #str + 2 -- 2 is the length of padding
							return " " .. str
						end,
						-- color = "01152d",
					},
				},
				lualine_b = {
					{
						"branch",
						cond = function()
							local should_show = vim.opt.columns:get() > 60
							if not should_show then
								branch_width = 0
							end
							return should_show
						end,
						fmt = function(str)
							if str == "" then
								branch_width = 0
								return ""
							end
							branch_width = #str + 2 + 2 -- 4 is the length of icon (unicode), 2 is the length of padding
							return str
						end,
					},
				},
				lualine_c = {
					{
						-- fill space to center the filetype + filename
						function()
							local used_space = mode_width * 2 + branch_width
							local win_width = vim.opt.columns:get()
							local fill_space = string.rep(" ", math.floor(win_width / 2) - used_space)
							return fill_space
						end,
						padding = { left = 0, right = 0 },
						cond = function()
							return vim.opt.columns:get() > 60
						end,
					},
					{
						"harpoon2",
						icon = "󰀱",
						indicators = { "H", "J", "K", "L" },
						active_indicators = { "[H]", "[J]", "[K]", "[L]" },
						color_active = { fg = "1A181A", bg = "78a9ff" },
						_separator = " ",
						no_harpoon = "Harpoon not loaded",
					},
				},
				lualine_x = {
					diagnostics,
					diff,
					{ "encoding", cond = hide_in_width },
					{ "filetype", cond = hide_in_width },
				},
				lualine_y = { "location" },
				lualine_z = { "progress" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = { { "location", padding = 0 } },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {
				lualine_a = {
					{
						"datetime",
						style = "default",
					},
				},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			extensions = { "fugitive" },
		})
	end,
}
