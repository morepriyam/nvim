return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
			},
		})
		vim.keymap.set("n", "<Leader>cf", vim.lsp.buf.format, { desc = "Format buffer" })

		-- Format the WHOLE project with the appropriate CLI formatters.
		-- LSP/none-ls only format open buffers; this runs each formatter's CLI
		-- across the project tree (respecting their ignore files), then reloads buffers.
		local function format_project()
			vim.cmd("silent! wall") -- write all buffers so formatters act on what you see

			local mason = vim.fn.stdpath("data") .. "/mason/bin/"
			local root = vim.fs.root(0, { ".git", "package.json", "Cargo.toml", "go.mod", "stylua.toml" })
				or vim.fn.getcwd()

			local function has(f)
				return vim.fn.filereadable(root .. "/" .. f) == 1
			end
			local function glob(p)
				return vim.fn.glob(root .. "/" .. p) ~= ""
			end
			local function bin(name)
				return vim.fn.executable(mason .. name) == 1 and (mason .. name) or name
			end

			local jobs = {}
			-- Web (prettier) -- auto-ignores node_modules
			if has("package.json") or glob(".prettierrc*") or glob("prettier.config.*") then
				jobs[#jobs + 1] = { "prettier", { bin("prettier"), "--write", "." } }
			end
			-- Lua (stylua) -- only if the project is configured for it
			if has("stylua.toml") or has(".stylua.toml") then
				jobs[#jobs + 1] = { "stylua", { bin("stylua"), "." } }
			end
			-- Rust
			if has("Cargo.toml") and vim.fn.executable("cargo") == 1 then
				jobs[#jobs + 1] = { "cargo fmt", { "cargo", "fmt" } }
			end
			-- Go
			if has("go.mod") and vim.fn.executable("gofmt") == 1 then
				jobs[#jobs + 1] = { "gofmt", { "gofmt", "-w", "." } }
			end
			-- Python (ruff)
			if has("pyproject.toml") or has("ruff.toml") or has(".ruff.toml") then
				jobs[#jobs + 1] = { "ruff", { bin("ruff"), "format", "." } }
			end

			if #jobs == 0 then
				vim.notify("FormatProject: no configured formatter found in " .. root, vim.log.levels.WARN)
				return
			end

			for _, job in ipairs(jobs) do
				local name, cmd = job[1], job[2]
				vim.notify("FormatProject: running " .. name .. " …")
				vim.system(cmd, { cwd = root, text = true }, function(res)
					vim.schedule(function()
						if res.code == 0 then
							vim.notify("FormatProject: " .. name .. " ✓")
							vim.cmd("checktime") -- reload any open buffers that changed on disk
						else
							vim.notify(
								"FormatProject: " .. name .. " failed\n" .. (res.stderr or res.stdout or ""),
								vim.log.levels.ERROR
							)
						end
					end)
				end)
			end
		end

		vim.api.nvim_create_user_command("FormatProject", format_project, { desc = "Format the whole project" })
		vim.keymap.set("n", "<Leader>cF", format_project, { desc = "Format whole project" })
	end,
}
