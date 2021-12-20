local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local servers = {
    "clangd",
    "hls",
    "jsonls",
    "pyright",
    "rust_analyzer",
    "sumneko_lua",
    "vimls",
}

local function on_attach(client, bufnr)
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
for _, lsp in ipairs(servers) do
    local settings = {}
    if lsp == "sumneko_lua" then
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                    -- Setup your lua path
                    path = runtime_path,
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { "vim" },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
            },
        }
    end
    lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = settings,
    })
end
