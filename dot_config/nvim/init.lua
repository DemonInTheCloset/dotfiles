-- Enable Filetype Plugin
vim.cmd("filetype plugin on")
vim.g.mapleader = " "

-- Continue reading configuration even if it contains an error
local function prequire(...)
    local ok, ret = pcall(require, ...)
    if not ok then
        print('Error: require("' .. ... .. '") failed')
        return nil
    end
    return ret
end

prequire("user/plugins")

-- [[ nvim settings ]] --
local CONFIG_PATH = (os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")) .. "/nvim"

-- Path to Python environment
vim.g.python3_host_prog = CONFIG_PATH .. "/.venv/bin/python"

-- Appearance
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.colorcolumn = "80" -- Color column 80
vim.opt.cursorline = true -- Highlight selected line
vim.opt.wrap = false -- Long lines don't wrap
vim.opt.signcolumn = "number" -- Merge line numbers with coc messages
vim.g.gruvbox_italic = 1 -- Allow italic font

-- In list mode show tabs and leading and trailing spaces
vim.opt.listchars = { tab = "==>", trail = "·", lead = "·" }

-- Colors
if vim.fn.has("termguicolors") == 1 then
    vim.o.termguicolors = true -- Allow Truecolor Support
end
vim.cmd("colorscheme gruvbox") -- Set colorscheme

-- Folds
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

-- Statusbar
vim.o.laststatus = 2 -- Statusbar is always visible
vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }

-- Global Tab and indentation settings
vim.o.smarttab = true -- Tabs are smarter
vim.opt.autoindent = true -- Auto indent lines
vim.opt.smartindent = true -- Indentation is smarter
vim.opt.expandtab = true -- Change tabs to spaces
vim.opt.tabstop = 4 -- A Tab is 4 spaces
vim.opt.softtabstop = 0 -- No softtabs
vim.opt.shiftwidth = 4 -- An indent is 4 spaces

-- Search settings
vim.o.path = ".,/usr/include,**"
vim.o.wildmenu = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true -- Search ignores cases

-- Options recommended by CoC
vim.o.updatetime = 300 -- Update every 300 ms
vim.o.timeoutlen = 200 -- Timeout after 200 ms
vim.o.hidden = true -- TextEdit might fail otherwise
vim.opt.shortmess:append("c") -- Don't pass messages to ins-completion-menu
vim.o.cmdheight = 3 -- Give more space for messages
vim.o.backup = false -- Some LSPs have problems with backups
vim.o.writebackup = false

-- [[ treesitter config ]] --
local treesitter = prequire("nvim-treesitter.configs")

treesitter.setup({
    -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = "maintained",
    -- install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = { enable = true },
    indent = { enable = true },
})

-- [[ snippets ]] --
local luasnip = prequire("user/snippets")

-- [[ nvim keymaps ]] --
-- Vim Dispatch
local noremap = { noremap = true }
vim.api.nvim_set_keymap("n", "<leader>m<CR>", "<cmd>Make %<CR>", noremap)
vim.api.nvim_set_keymap("n", "<leader>`<CR>", "<cmd>Dispatch %<CR>", noremap)

-- Quickfix List
vim.api.nvim_set_keymap("n", "<leader>qo", "<cmd>Copen<CR>", noremap)
vim.api.nvim_set_keymap("n", "<leader>qq", "<cmd>cclose<CR>", noremap)
vim.api.nvim_set_keymap("n", "<leader>qj", "<cmd>cnext<CR>", noremap)
vim.api.nvim_set_keymap("n", "<leader>qk", "<cmd>cprev<CR>", noremap)

-- Diagnostics
vim.api.nvim_set_keymap("n", "<leader>dj", "<cmd>lua vim.diagnostic.goto_next()<CR>", noremap)
vim.api.nvim_set_keymap("n", "<leader>dk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", noremap)

-- Telescope
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", noremap)
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", noremap)
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", noremap)
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", noremap)
vim.api.nvim_set_keymap("n", "<leader>fa", "<cmd>Telescope lsp_code_actions<CR>", noremap)
vim.api.nvim_set_keymap("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", noremap)
vim.api.nvim_set_keymap("n", "<leader>fq", "<cmd>Telescope quickfix<CR>", noremap)

-- Miscellaneous
vim.api.nvim_set_keymap("n", "<leader>cd", "<cmd>cd %:p:h<CR>", noremap)

-- LSP
local function lsp_set_keymaps(bufnr, opts)
    -- LSP actions
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>A", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

    -- LSP goto ...
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
end

-- [[ nvim-cmp config ]] --
local cmp = prequire("cmp")

local lspkind = prequire("lspkind")
local lspk_format = lspkind.cmp_format({ with_text = false, maxwidth = 50 })

-- local  luasnip = prequire("luasnip")
local snippets = {
    expand = function(args)
        luasnip.lsp_expand(args.body)
    end,
}

cmp.setup({
    snippet = snippets,
    mapping = {
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable,
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "luasnip" },
    }, {
        { name = "buffer" },
    }),
    formatting = {
        format = lspk_format,
    },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

-- [[ LSP config ]] --
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local function on_attach(_, bufnr)
    local opts = { noremap = true }
    -- Omnifunc
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Keymaps
    lsp_set_keymaps(bufnr, opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_lsp = prequire("cmp_nvim_lsp")
capabilities = cmp_lsp.update_capabilities(capabilities)

local lspconfig = prequire("lspconfig")

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

-- [[ plugins ]] --
local colorizer_conf = {}
colorizer_conf["*"] = { names = false, RRGGBBAA = true }
prequire("colorizer").setup(colorizer_conf)

-- [[ null_ls ]] --
local null_ls = prequire("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.google_java_format,
    },
})

-- [[ telescope ]] --
prequire("telescope").load_extension("fzy_native")

-- [[ neogit ]] --
prequire("neogit").setup()

-- [[ statusline ]] --
local statusline = prequire("lualine")

statusline.setup({
    options = {
        icons_enabled = true,
        theme = "gruvbox",

        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat" },
        lualine_y = { "filetype" },
        lualine_z = { "progress", "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
})

-- [[ augroups ]] --
local function define_augroup(name, autocmds)
    vim.cmd("augroup " .. name)
    vim.cmd("autocmd!")
    autocmds()
    vim.cmd("augroup END")
end

define_augroup("OpenFolds", function()
    vim.cmd("autocmd BufRead * silent! %foldopen!")
end)

define_augroup("FTApperance", function()
    vim.cmd("autocmd FileType c setlocal tabstop=8 shiftwidth=8 noexpandtab")
    vim.cmd("autocmd FileType porth setlocal tabstop=2 shiftwidth=2")
    vim.cmd("autocmd FileType haskell setlocal tabstop=2 shiftwidth=2")
    vim.cmd("autocmd FileType markdown setlocal tabstop=2 shiftwidth=2 textwidth=80 wrap")
    vim.cmd("autocmd TermOpen * setlocal nonumber norelativenumber")
end)

define_augroup("DispatchCompiler", function()
    vim.cmd("autocmd FileType java let b:dispatch = 'gradle build'")
    vim.cmd("autocmd FileType python let b:dispatch = 'mypy %'")
    vim.cmd("autocmd FileType markdown let b:dispatch = 'pandoc --pdf-engine=xelatex -f markdown % -o %.pdf'")
    vim.cmd("autocmd FileType tex let b:dispatch = 'latexmk -pvc -pdflua %'")
    vim.cmd("autocmd FileType plaintex let b:dispatch = 'latexmk -pvc -pdf %'")
    vim.cmd("autocmd FileType sh,bash :compiler shellcheck")
    vim.cmd("autocmd FileType porth :compiler porth")
end)

define_augroup("TemplateFiles", function()
    vim.cmd("autocmd BufNewFile *.py  0r ~/.config/nvim/templates/skeleton.py")
    vim.cmd("autocmd BufNewFile *.zsh 0r ~/.config/nvim/templates/skeleton.zsh")
end)

define_augroup("TrimWhiteSpace", function()
    vim.cmd("autocmd BufWritePre *.md :%s/\\s\\+$//e")
    vim.cmd("autocmd BufWritePre *.py :%s/\\s\\+$//e")
end)
