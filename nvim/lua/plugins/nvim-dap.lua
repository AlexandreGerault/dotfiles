return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",

			"mason-org/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",

			"mfussenegger/nvim-dap-python",
			"Mythos-404/xmake.nvim",
		},

		config = function()
			local dap = require("dap")

			-- =========================
			-- Mason
			-- =========================
			require("mason-nvim-dap").setup({
				ensure_installed = {
					"python",
					"codelldb",
					"js",
				},
				automatic_installation = true,
			})

			-- =========================
			-- UI
			-- =========================
			local dapui = require("dapui")
			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- =========================
			-- Keymaps (default-like)
			-- =========================
			vim.keymap.set("n", "<F5>", dap.continue)
			vim.keymap.set("n", "<F10>", dap.step_over)
			vim.keymap.set("n", "<F11>", dap.step_into)
			vim.keymap.set("n", "<F12>", dap.step_out)
			vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint)

			-- =========================
			-- Python
			-- =========================
			-- Use the debugpy installed by Mason; the debuggee interpreter is still
			-- auto-detected from $VIRTUAL_ENV / ./venv / ./.venv by nvim-dap-python.
			require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")

			-- =========================
			-- C / C++ (XMAKE INTEGRATION)
			-- =========================
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
					args = { "--port", "${port}" },
				},
			}

			-- 🔥 XMAKE bridge
			local function xmake_dap_program()
				-- get current target from xmake.nvim
				local ok, info = pcall(require, "xmake.info")
				if not ok then
					vim.notify("xmake.nvim not available", vim.log.levels.ERROR)
					return nil
				end

				local target = info.target.current
				if target == "" then
					vim.notify("No xmake target selected (:Xmake select_target)", vim.log.levels.ERROR)
					return nil
				end

				-- build first
				vim.cmd("Xmake build")

				-- get binary path
				local result = vim.fn.system("xmake show -t " .. target)
				local program = result:match("targetfile:%s*(.-)\n")

				if not program then
					vim.notify("Failed to get xmake target binary", vim.log.levels.ERROR)
					return nil
				end

				return program
			end

			dap.configurations.cpp = {
				{
					name = "Xmake Debug",
					type = "codelldb",
					request = "launch",
					program = xmake_dap_program,
					cwd = "${workspaceFolder}",
				},
			}

			dap.configurations.c = dap.configurations.cpp

			-- =========================
			-- Rust (NO xmake)
			-- =========================
			dap.configurations.rust = {
				{
					name = "Rust Debug",
					type = "codelldb",
					request = "launch",
					program = function()
						vim.cmd("!cargo build")
						return vim.fn.getcwd() .. "/target/debug/" .. vim.fn.input("Binary name: ")
					end,
					cwd = "${workspaceFolder}",
				},
			}

			-- =========================
			-- JavaScript
			-- =========================
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}

			dap.configurations.javascript = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
			}

			dap.configurations.typescript = dap.configurations.javascript
		end,
	},
}
