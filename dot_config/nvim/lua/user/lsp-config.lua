local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local function on_attach(_, bufnr)
	local opts = { noremap = true }
	-- Omnifunc
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Keymaps
    -- LSP actions
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>A", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

    -- LSP goto ...
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)

    -- Diagnostics
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)

    -- Telescope
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>td", "<cmd>Telescope diagnostics<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ta", "<cmd>Telescope lsp_code_actions<CR>", opts)
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
