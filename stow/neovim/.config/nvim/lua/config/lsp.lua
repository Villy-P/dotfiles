local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("lua_ls", {
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
		},
	},
})

vim.lsp.config("ts_ls", { capabilities = capabilities })
vim.lsp.config("svelte", { capabilities = capabilities })
vim.lsp.config("tailwindcss", { capabilities = capabilities })
vim.lsp.config("cmake", { capabilities = capabilities })
vim.lsp.config("clangd", { capabilities = capabilities })
vim.lsp.config("jdtls", {
	capabilities = capabilities,
	settings = {
		java = {
			format = {
				settings = {
					url = vim.fn.expand("/home/valerius/projects/cs314-hygiene-checker/format.xml"),
					profile = "Custom-Java-Rules",
				},
			},
		},
	},
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("svelte")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("cmake")
vim.lsp.enable("clangd")
vim.lsp.enable("jdtls")

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.java",
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})
