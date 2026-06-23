return {
	"mrcjkb/rustaceanvim",
	version = "^6",
	lazy = false, -- this plugin auto-activates on Rust files; do not lazy-load it
	config = function()
		vim.g.rustaceanvim = {
			-- LSP (rust-analyzer) configuration
			server = {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				on_attach = function(_, bufnr)
					local opts = { noremap = true, silent = true, buffer = bufnr }
					vim.keymap.set("n", "K", function()
						vim.cmd.RustLsp({ "hover", "actions" })
					end, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
					vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
					-- Grouped code actions (rustaceanvim's enhanced version)
					vim.keymap.set({ "n", "v" }, "<Leader>ca", function()
						vim.cmd.RustLsp("codeAction")
					end, opts)
					-- Run / debug / macro-expand
					vim.keymap.set("n", "<Leader>rr", function()
						vim.cmd.RustLsp("runnables")
					end, opts)
					vim.keymap.set("n", "<Leader>rd", function()
						vim.cmd.RustLsp("debuggables")
					end, opts)
					vim.keymap.set("n", "<Leader>rm", function()
						vim.cmd.RustLsp("expandMacro")
					end, opts)
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end,
				default_settings = {
					["rust-analyzer"] = {
						cargo = { allFeatures = true },
						checkOnSave = true,
						check = { command = "clippy" },
					},
				},
			},
		}
	end,
}
