return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"typescript",
					"tsx",
					"svelte",
					"markdown",
					"markdown_inline",
					"cmake",
					"c",
					"cpp",
					"c_sharp",
					"java",
				},
				highlight = { enable = true },
				indent = { enable = true },
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
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
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
					},
					format_on_save = {
						timeout_ms = 500,
						lsp_fallback = true,
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
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = { "markdown" },
		config = function()
			require("render-markdown").setup({})
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
}
