return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio", -- required by nvim-dap-ui
			"theHamsta/nvim-dap-virtual-text",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Install debug adapters via mason.
			-- Rust uses codelldb (also driven by rustaceanvim); JS/TS uses js-debug-adapter.
			require("mason-nvim-dap").setup({
				ensure_installed = { "java-debug-adapter", "java-test", "codelldb", "js-debug-adapter" },
				automatic_installation = true,
				handlers = {}, -- use default handlers; we configure js manually below
			})

			dapui.setup()
			require("nvim-dap-virtual-text").setup()

			-- Auto open/close the debug UI
			dap.listeners.before.attach.dapui_config = function() dapui.open() end
			dap.listeners.before.launch.dapui_config = function() dapui.open() end
			dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
			dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

			-- Gutter signs
			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", numhl = "" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "Visual" })

			-- JS/TS adapter (pwa-node) via mason's js-debug-adapter
			local js_debug = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = { js_debug, "${port}" },
				},
			}
			for _, lang in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
				dap.configurations[lang] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch current file (node)",
						program = "${file}",
						cwd = "${workspaceFolder}",
						sourceMaps = true,
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach to running node process",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
						sourceMaps = true,
					},
				}
			end

			-- Keymaps
			local map = vim.keymap.set
			map("n", "<F5>", dap.continue, { desc = "DAP Continue / Start" })
			map("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
			map("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
			map("n", "<F9>", dap.step_out, { desc = "DAP Step Out" })
			map("n", "<Leader>db", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
			map("n", "<Leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "DAP Conditional Breakpoint" })
			map("n", "<Leader>dr", dap.repl.toggle, { desc = "DAP REPL" })
			map("n", "<Leader>dl", dap.run_last, { desc = "DAP Run Last" })
			map("n", "<Leader>du", dapui.toggle, { desc = "DAP UI Toggle" })
			map("n", "<Leader>dt", dap.terminate, { desc = "DAP Terminate" })
		end,
	},
}
