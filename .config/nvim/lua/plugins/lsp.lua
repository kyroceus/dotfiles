return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "clangd" }, -- Add your LSP servers here
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			local lspconfig = require("lspconfig")
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

			local on_attach = function(_, bufnr)
				local bufmap = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end

				bufmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
				bufmap("n", "K", vim.lsp.buf.hover, "Hover info")
				bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
				bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
			end

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						on_attach = on_attach,
						capabilities = lsp_capabilities,
					})
				end,
			})

			-- Specific LSP server settings (example for lua_ls)
			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				capabilities = lsp_capabilities,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})

			-- Clangd setup
			lspconfig.clangd.setup({
				on_attach = on_attach,
				capabilities = lsp_capabilities,
			})

			-- Dart setup
			lspconfig.dartls.setup({
				cmd = { "dart", "language-server", "--protocol=lsp" },
				filetypes = { "dart" },
				root_dir = lspconfig.util.root_pattern("pubspec.yaml"),
				init_options = {
					closingLabels = true,
					flutterOutline = true,
					onlyAnalyzeProjectsWithOpenFiles = true,
					outline = true,
					suggestFromUnimportedLibraries = true,
					settings = {
						dart = {
							completeFunctionCalls = true,
							showTodos = true,
						},
					},
				},
				on_attach = on_attach,
				capabilities = lsp_capabilities,
			})

			-- astro setup
			lspconfig.astro.setup({
				on_attach = on_attach,
				capabilities = lsp_capabilities,
			})

			lspconfig.cssls.setup({
				on_attach = on_attach,
				capabilities = lsp_capabilities,
			})

			lspconfig.tailwindcss.setup({
				on_attach = on_attach,
				capabilities = lsp_capabilities,
			})

			lspconfig.astro.setup({
				on_attach = on_attach,
				capabilities = lsp_capabilities,
				init_options = {
					typescript = {
						tsdk = vim.fn.expand("~/.nvm/versions/node/v22.12.0/lib/node_modules/typescript/lib"),
					},
				},
				filetypes = { "astro", "javascript", "typescript", "css", "html" },
				root_dir = lspconfig.util.root_pattern("astro.config.*", ".git"),
				settings = {
					astro = {
						enableTelemetry = false,
					},
				},
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
}
