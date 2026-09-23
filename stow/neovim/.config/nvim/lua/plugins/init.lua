return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local parsers = {
				"lua",
				"vim",
				"vimdoc",
				"typescript",
				"tsx",
				"svelte",
				"markdown",
				"markdown_inline",
				"c",
				"cpp",
				"bash",
				"python",
			}

			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},

	{
		"pocco81/auto-save.nvim",
		config = function()
			require("auto-save").setup({
				enabled = true,
				trigger_events = { "InsertLeave", "TextChanged" },
			})
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>" },
		},
	},

	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>" },
		},
		config = function()
			require("nvim-tree").setup({})
		end,
	},

	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"neovim/nvim-lspconfig",
	},

	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false,
				},
			})
		end,
	},

	{
		{
			"stevearc/conform.nvim",
			event = "BufWritePre",
			config = function()
				require("conform").setup({
					formatters_by_ft = {
						lua = { "stylua" },
						cmake = { "cmake_format" },
						typescript = { "prettierd" },
						javascript = { "prettierd" },
						svelte = { "prettierd" },
						tex = { "latexindent" },
						markdown = { "prettierd" },
					},
					formatters = {
						prettierd = {
							options = {
								ft_parsers = {
									svelte = "svelte",
									typescript = "typescript",
									javascript = "babel",
								},
							},
						},
					},
				})
			end,
		},
	},

	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("tokyonight")
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			require("config.cmp")
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
			})
		end,
	},

	{
		"seblyng/roslyn.nvim",
		ft = "cs",
		config = function()
			require("roslyn").setup({
				config = {
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
				},
			})
		end,
	},

	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("config.lint")
		end,
	},

	{
		"Senal-D-A-Gunaratna/matugen.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			load_theme = true,
			palette_path = "~/.config/matugen/themes/nvim-colors.json",
		},
	},

	{
		"lervag/vimtex",
		lazy = false,
		init = function()
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_quickfix_mode = 0
			vim.g.tex_flavor = "latex"
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
					section_separators = "",
					component_separators = "|",
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},

	{
		"onsails/lspkind.nvim",
	},

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		keys = { "<C-\\>" },
		config = function()
			require("toggleterm").setup({
				size = 15,
				open_mapping = [[<C-\>]],
				direction = "float",
				float_opts = {
					border = "curved",
				},
			})

			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
			end

			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
		end,
	},

	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
				filetypes = {
					markdown = true,
					help = false,
				},
			})
		end,
	},

	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers",
					diagnostics = "nvim_lsp",
					separator_style = "thin",
					show_buffer_close_icons = true,
					show_close_icon = false,
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							highlight = "Directory",
							separator = true,
						},
					},
				},
			})
		end,
	},

	{
		"Bekaboo/dropbar.nvim",
		dependencies = { "nvim-telescope/telescope-fzf-native.nvim" },
		config = function()
			require("dropbar").setup({})

			vim.keymap.set("n", "<leader>;", require("dropbar.api").pick, { desc = "Pick symbol in dropbar" })
		end,
	},

	{
		"declancm/cinnamon.nvim",
		event = "VeryLazy",
		config = function()
			require("cinnamon").setup({
				keymaps = {
					basic = true,
					extra = true,
				},
				options = {
					mode = "cursor",
					delay = 5,
					max_delay = 200,
				},
			})
		end,
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
}
