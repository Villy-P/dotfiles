local lint = require("lint")

lint.linters_by_ft = {
	java = { "checkstyle" },
}

-- Completely override checkstyle to use standard text parsing
lint.linters.checkstyle = {
	cmd = "checkstyle",
	stdin = false,
	append_fname = true, -- Automatically appends the active file path to the end
	ignore_exitcode = true,
	args = {
		"-c",
		vim.fn.expand("/home/valerius/projects/cs314-hygiene-checker/checkstyle.xml"),
	},
	-- Parse standard Checkstyle text output: [WARN] /path/to/File.java:line:col: Message [Rule]
	parser = require("lint.parser").from_pattern(
		"%[(%w+)%]%s+(.-):(%d+):(%d+):%s+(.*)",
		{ "severity", "file", "lnum", "col", "message" },
		{
			["WARN"] = vim.diagnostic.severity.WARN,
			["ERROR"] = vim.diagnostic.severity.ERROR,
			["INFO"] = vim.diagnostic.severity.INFO,
		},
		{ ["source"] = "checkstyle" }
	),
}

-- Trigger linting automatically
vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
	callback = function()
		lint.try_lint()
	end,
})
