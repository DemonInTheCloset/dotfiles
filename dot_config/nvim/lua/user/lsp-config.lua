local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local function on_attach(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_lsp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_lsp_ok then
	capabilities = cmp_lsp.update_capabilities(capabilities)
end

local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
	return
end

lspconfig["clangd"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "clangd", "--clang-tidy" },
})
lspconfig["hls"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
lspconfig["jsonls"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "vscode-json-languageserver", "--stdio" },
})
lspconfig["pyright"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
lspconfig["remark_ls"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
})
lspconfig["rust_analyzer"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
lspconfig["sumneko_lua"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = runtime_path,
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})
lspconfig["vimls"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
