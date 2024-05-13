local Plugin = { "nvim-telescope/telescope.nvim" }

Plugin.cmd = { "Telescope" }

Plugin.dependencies = {
	{ "nvim-treesitter/nvim-treesitter" },
	{ "nvim-lua/plenary.nvim" },
	{ "debugloop/telescope-undo.nvim" },
	--{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}

function Plugin.config()
	local telecope = require("telescope")
	local tsu = require("telescope-undo.actions")

	telecope.setup({
		defaults = {
			vimgrep_arguments = {
				"rg",
				"-L",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
			prompt_prefix = "   ",
			selection_caret = "  ",
			entry_prefix = "  ",
			initial_mode = "insert",
			selection_strategy = "reset",
			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = 0.87,
				height = 0.80,
				preview_cutoff = 120,
			},
			file_sorter = require("telescope.sorters").get_fuzzy_file,
			file_ignore_patterns = { "node_modules" },
			generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
			path_display = { "truncate" },
			winblend = 0,
			border = {},
			borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			color_devicons = true,
			set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
			file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
			-- Developer configurations: Not meant for general override
			buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
			mappings = {
				i = {
					["<C-Down>"] = require("telescope.actions").cycle_history_next,
					["<C-Up>"] = require("telescope.actions").cycle_history_prev,
				},
				n = { ["q"] = require("telescope.actions").close },
			},

			pickers = {
				colorscheme = {
					enable_preview = true,
				},
			},

			extensions_list = { "themes", "terms" },

			extensions = {
				--fzf = {
				--	fuzzy = true, -- false will only do exact matching
				--	override_generic_sorter = true, -- override the generic sorter
				--	override_file_sorter = true, -- override the file sorter
				--	case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				--	-- the default case_mode is "smart_case"
				--},
				undo = {
					side_by_side = true,
					layout_strategy = "vertical",
					layout_config = {
						preview_height = 0.8,
					},
					mappings = {
						i = {
							["<cr>"] = tsu.yank_additions,
							["<S-cr>"] = tsu.yank_deletions,
							["<C-cr>"] = tsu.restore,
							-- alternative defaults, for users whose terminals do questionable things with modified <cr>
							["<C-y>"] = tsu.yank_deletions,
							["<C-r>"] = tsu.restore,
						},
						n = {
							["y"] = tsu.yank_additions,
							["Y"] = tsu.yank_deletions,
							["u"] = tsu.restore,
						},
					},
				},
				aerial = {
					-- Display symbols as <root>.<parent>.<symbol>
					show_nesting = {
						["_"] = false, -- This key will be the default
						json = true, -- You can set the option for specific filetypes
						yaml = true,
					},
				},
			},
		},
	})

	--telecope.load_extension("fzf")
	require("telescope").load_extension("undo")
end

return Plugin
