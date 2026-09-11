local cmp = require("cmp")
local lspkind = require("lspkind")

local custom_border = {
	"╭",
	"─",
	"╮",
	"│",
	"╯",
	"─",
	"╰",
	"│",
}

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
	}),
	sources = {
		{ name = "nvim_lsp" },
	},
	window = {
		completion = cmp.config.window.bordered({
			border = custom_border,
		}),
		documentation = cmp.config.window.bordered({
			border = custom_border,
		}),
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},
})
