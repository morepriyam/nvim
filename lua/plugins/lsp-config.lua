return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"b0o/schemastore.nvim", -- JSON schemas (package.json, tsconfig, etc.) for jsonls
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Servers enabled directly via lspconfig.
			-- NOTE: rust_analyzer is intentionally absent here -- rustaceanvim manages Rust.
			local servers = {
				"lua_ls",
				"ts_ls",
				"prismals",
				"tailwindcss",
				"pyright", -- Python: types / completion
				"ruff", -- Python: lint + format
				"gopls", -- Go: LSP + formatting
				"clangd", -- C/C++: LSP + formatting
				"html",
				"cssls",
				"jsonls",
			}

			require("mason-lspconfig").setup({
				-- Install the enabled servers plus rust_analyzer (used by rustaceanvim).
				ensure_installed = vim.list_extend(vim.deepcopy(servers), { "rust_analyzer" }),
				-- We enable servers explicitly below. Without this, mason-lspconfig v2
				-- auto-enables every mason package with an lsp/ config -- including
				-- formatters like stylua (launched as `stylua --lsp`), which then crash.
				automatic_enable = false,
			})

			-- Apply default capabilities to every server (Neovim 0.11+ API)
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			-- JSON: validate against schemas from SchemaStore
			vim.lsp.config("jsonls", {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})

			-- Enable the servers; nvim-lspconfig ships the per-server lsp/*.lua configs
			vim.lsp.enable(servers)

			-- Buffer-local keymaps + inlay hints whenever an LSP attaches
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					local opts = { noremap = true, silent = true, buffer = ev.buf }
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
					vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)

					local client = vim.lsp.get_client_by_id(ev.data.client_id)

					-- Let prettier (none-ls) own formatting for web filetypes; silence the
					-- overlapping LSP formatters so they don't fight prettier.
					if client and (client.name == "ts_ls" or client.name == "html" or client.name == "cssls" or client.name == "jsonls") then
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentRangeFormattingProvider = false
					end

					-- Inlay hints (inline types / parameter names) when supported
					if client and client:supports_method("textDocument/inlayHint") then
						vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
					end
					vim.keymap.set("n", "<Leader>ih", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
					end, opts)
				end,
			})
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
		ft = { "java" },
		config = function()
			-- Create an autocmd group for JDTLS
			local jdtls_group = vim.api.nvim_create_augroup("JDTLS", { clear = true })

			-- Setup JDTLS for each Java buffer
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "java",
				group = jdtls_group,
				callback = function()
					local jdtls = require("jdtls")
					local home = os.getenv("HOME")
					local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
					
					-- Create workspace directory if it doesn't exist
					local workspace_dir = home .. "/.local/share/eclipse/" .. project_name
					local workspace_folder = vim.fn.fnamemodify(workspace_dir, ":p")
					vim.fn.mkdir(workspace_folder, "p")

					-- Find java debug bundles if they exist
					local bundles = {}
					local debug_bundle = home .. "/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
					if vim.fn.glob(debug_bundle) ~= "" then
						vim.list_extend(bundles, vim.split(vim.fn.glob(debug_bundle), "\n"))
					end

					local config = {
						cmd = {
							"java",
							"-Declipse.application=org.eclipse.jdt.ls.core.id1",
							"-Dosgi.bundles.defaultStartLevel=4",
							"-Declipse.product=org.eclipse.jdt.ls.core.product",
							"-Dlog.protocol=true",
							"-Dlog.level=ALL",
							"-Xmx1g",
							"--add-modules=ALL-SYSTEM",
							"--add-opens", "java.base/java.util=ALL-UNNAMED",
							"--add-opens", "java.base/java.lang=ALL-UNNAMED",
							"-jar",
							vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
							"-configuration", home .. "/.local/share/nvim/mason/packages/jdtls/config_mac",
							"-data", workspace_dir,
						},
						root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml" }),
						settings = {
							java = {
								configuration = {
									updateBuildConfiguration = "automatic",
									runtimes = {
										{
											name = "JavaSE-21",
											path = "/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home",
										},
									},
								},
								maven = {
									downloadSources = true,
								},
								implementationsCodeLens = {
									enabled = true,
								},
								referencesCodeLens = {
									enabled = true,
								},
								references = {
									includeDecompiledSources = true,
								},
								format = {
									enabled = true,
									settings = {
										url = home .. "/.local/share/eclipse/eclipse-java-google-style.xml",
										profile = "GoogleStyle",
									},
								},
								import = {
									gradle = {
										enabled = true,
										wrapper = {
											enabled = true,
										},
									},
									maven = {
										enabled = true,
									},
									exclusions = {
										"**/node_modules/**",
										"**/.metadata/**",
										"**/archetype-resources/**",
										"**/META-INF/maven/**",
										"/**/test/**",
									},
								},
								project = {
									resourceFilters = {
										"node_modules",
										".git",
										".idea",
										"target",
										"bin",
									},
								},
								autobuild = {
									enabled = false,
								},
								completion = {
									enabled = true,
									guessMethodArguments = true,
									favoriteStaticMembers = {
										"org.junit.Assert.*",
										"org.junit.Assume.*",
										"org.junit.jupiter.api.Assertions.*",
										"org.junit.jupiter.api.Assumptions.*",
										"org.junit.jupiter.api.DynamicContainer.*",
										"org.junit.jupiter.api.DynamicTest.*",
									},
								},
							},
						},
						init_options = {
							bundles = bundles,
							extendedClientCapabilities = {
								progressReportProvider = true,
								classFileContentsSupport = true,
								generateToStringPromptSupport = true,
								hashCodeEqualsPromptSupport = true,
								advancedExtractRefactoringSupport = true,
								advancedOrganizeImportsSupport = true,
								generateConstructorsPromptSupport = true,
								generateDelegateMethodsPromptSupport = true,
								moveRefactoringSupport = true,
								overrideMethodsPromptSupport = true,
								executeClientCommandSupport = true,
								shouldLanguageServerExitOnShutdown = true,
								onConfigurationChanged = true,
								compilationErrors = true,
							},
						},
						on_attach = function(client, bufnr)
							local opts = { noremap = true, silent = true, buffer = bufnr }
							vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
							vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
							vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
							vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
							vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, opts)
							vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
							vim.keymap.set("n", "<Leader>df", function()
								jdtls.test_class()
							end, opts)
							vim.keymap.set("n", "<Leader>dn", function()
								jdtls.test_nearest_method()
							end, opts)

							vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

							if client.server_capabilities.documentFormattingProvider then
								vim.api.nvim_create_autocmd("BufWritePre", {
									group = vim.api.nvim_create_augroup("Format", { clear = true }),
									buffer = bufnr,
									callback = function() vim.lsp.buf.format() end
								})
							end

							vim.api.nvim_create_autocmd({ "BufWritePost" }, {
								pattern = { "*.java" },
								callback = function()
									client.notify("workspace/didChangeWatchedFiles")
								end,
							})
						end,
					}

					jdtls.start_or_attach(config)
				end,
			})
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				tailwind = true,
			},
		},
	},
}
