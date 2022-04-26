-- Enable Filetype Plugin
vim.g.do_filetype_lua = 1 -- Use filetype.lua
-- vim.g.did_load_filetypes = 1 -- Disable filetype.vim
vim.cmd "filetype plugin on"
vim.g.mapleader = " "

-- Continue reading configuration even if it contains an error
local function prequire(...)
	local ok, ret = pcall(require, ...)
	if not ok then
		print('Error: require("' .. ... .. '") failed')
		return {}
	end
	return ret
end

prequire "user/plugins"

-- [[ nvim settings ]] --
local CONFIG_PATH = (os.getenv "XDG_CONFIG_HOME" or (os.getenv "HOME" .. "/.config")) .. "/nvim"

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
if vim.fn.has "termguicolors" == 1 then
	vim.o.termguicolors = true -- Allow Truecolor Support
end
vim.cmd "colorscheme gruvbox" -- Set colorscheme

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
vim.o.smartcase = true -- Unless it has a capital letter

-- Options recommended by CoC
vim.o.updatetime = 300 -- Update every 300 ms
vim.o.timeoutlen = 200 -- Timeout after 200 ms
vim.o.hidden = true -- TextEdit might fail otherwise
vim.opt.shortmess:append "c" -- Don't pass messages to ins-completion-menu
vim.o.cmdheight = 3 -- Give more space for messages
vim.o.backup = false -- Some LSPs have problems with backups
vim.o.writebackup = false

-- [[ treesitter config ]] --
local treesitter = prequire "nvim-treesitter.configs"

treesitter.setup {
	ensure_installed = "all",
	-- install languages synchronously (only applied to `ensure_installed`)
	sync_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = { enable = true },
	indent = { enable = true },
}

-- [[ snippets ]] --
local luasnip = prequire "user/snippets"

-- [[ nvim keymaps ]] --
-- Vim Dispatch
vim.keymap.set("n", "<leader>m<CR>", "<cmd>Make %<CR>", { noremap = true })
vim.keymap.set("n", "<leader>`<CR>", "<cmd>Dispatch %<CR>", { noremap = true })

-- Quickfix List
vim.keymap.set("n", "<leader>qo", "<cmd>Copen<CR>", { noremap = true })
vim.keymap.set("n", "<leader>qq", "<cmd>cclose<CR>", { noremap = true })
vim.keymap.set("n", "<leader>qj", "<cmd>cnext<CR>", { noremap = true })
vim.keymap.set("n", "<leader>qk", "<cmd>cprev<CR>", { noremap = true })

-- Diagnostics
vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { noremap = true })
vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { noremap = true })

-- Telescope
local telescope_builtin = prequire "telescope.builtin"
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { noremap = true })
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, { noremap = true })
vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, { noremap = true })
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, { noremap = true })
vim.keymap.set("n", "<leader>fd", telescope_builtin.diagnostics, { noremap = true })
vim.keymap.set("n", "<leader>fq", telescope_builtin.quickfix, { noremap = true })

-- Keep selection while indenting
vim.keymap.set("v", ">", ">gv", { noremap = true })
vim.keymap.set("v", "<", "<gv", { noremap = true })

-- EasyAlign
vim.keymap.set({ "x", "n" }, "ga", "<Plug>(EasyAlign)", { noremap = false })

-- Miscellaneous
vim.keymap.set("n", "<leader>cd", "<cmd>cd %:p:h<CR>", { noremap = true })
vim.keymap.set("n", "<leader>git", "<cmd>Neogit<CR>", { noremap = true })

-- LSP
local function lsp_set_keymaps(bufnr)
	-- LSP actions
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, buffer = bufnr })
	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { noremap = true, buffer = bufnr })
	vim.keymap.set("n", "<leader>fa", vim.lsp.buf.code_action, { noremap = true, buffer = bufnr })
	vim.keymap.set(
		"v",
		"<leader>fa",
		vim.lsp.buf.range_code_action,
		{ noremap = true, buffer = bufnr }
	)

	-- LSP goto ...
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, buffer = bufnr })
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { noremap = true, buffer = bufnr })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true, buffer = bufnr })
end

-- [[ nvim-cmp config ]] --
local cmp = prequire "cmp"

local lspkind = prequire "lspkind"
local lspk_format = lspkind.cmp_format { with_text = false, maxwidth = 50 }

-- local  luasnip = prequire("luasnip")
local snippets = {
	expand = function(args)
		luasnip.lsp_expand(args.body)
	end,
}

cmp.setup {
	snippet = snippets,
	mapping = {
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable,
		["<C-e>"] = cmp.mapping {
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		},
		["<CR>"] = cmp.mapping.confirm { select = true },
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
}

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
	-- Omnifunc
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Keymaps
	lsp_set_keymaps(bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_lsp = prequire "cmp_nvim_lsp"
capabilities = cmp_lsp.update_capabilities(capabilities)

local lspconfig = prequire "lspconfig"

lspconfig["clangd"].setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
lspconfig["hls"].setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
lspconfig["jsonls"].setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
lspconfig["pyright"].setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
lspconfig["rust_analyzer"].setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
lspconfig["sumneko_lua"].setup {
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
			telemetry = {
				enable = false,
			},
		},
	},
}
lspconfig["vimls"].setup {
	on_attach = on_attach,
	capabilities = capabilities,
}

-- [[ plugins ]] --
local colorizer_conf = {}
colorizer_conf["*"] = { names = false, RRGGBBAA = true }
prequire("colorizer").setup(colorizer_conf)

-- [[ null_ls ]] --
local null_ls = prequire "null-ls"
null_ls.setup {
	sources = {
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.google_java_format,
		null_ls.builtins.formatting.latexindent,
		null_ls.builtins.formatting.nginx_beautifier,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.reorder_python_imports.with {
			extra_args = { "--application-directories=.:src" },
		},
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.shellharden,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.taplo,

		null_ls.builtins.diagnostics.checkmake,
		null_ls.builtins.diagnostics.chktex,
		null_ls.builtins.diagnostics.mypy,
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.diagnostics.trail_space,
		-- null_ls.builtins.diagnostics.vulture,
		null_ls.builtins.diagnostics.zsh,

		null_ls.builtins.code_actions.shellcheck,
	},
	-- Format On Save
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd [[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
            augroup END
            ]]
		end
	end,
}

-- [[ telescope ]] --
local telescope = prequire "telescope"
local function ptelescope_load_extension(extension)
	local ok, _ = pcall(telescope.load_extension, extension)
	if not ok then
		print("Error[Telescope]: Failed to load " .. extension .. " extension")
	end
end

telescope.setup {
	extensions = {
		["ui-select"] = {
			prequire("telescope.themes").get_dropdown {},
		},
	},
}

ptelescope_load_extension "fzy_native"
ptelescope_load_extension "ui-select"

-- [[ neogit ]] --
prequire("neogit").setup()

-- [[ statusline ]] --
local statusline = prequire "lualine"

statusline.setup {
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
}

-- [[ augroups ]] --
local open_folds = vim.api.nvim_create_augroup("OpenFolds", {})
vim.api.nvim_create_autocmd(
	"BufRead",
	{ group = open_folds, pattern = "*", command = "silent! %foldopen!" }
)

local file_type_override = vim.api.nvim_create_augroup("FileTypeOverride", {})
vim.api.nvim_create_autocmd("FileType", {
	group = file_type_override,
	pattern = { "c" },
	-- Set indent width to 8 spaces and use tabs
	callback = function()
		vim.bo.tabstop = 8
		vim.bo.shiftwidth = 8
		vim.bo.expandtab = false
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = file_type_override,
	pattern = { "porth", "haskell", "markdown" },
	-- Set indent width to 2 spaces
	callback = function()
		vim.bo.tabstop = 2
		vim.bo.shiftwidth = 2
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = file_type_override,
	pattern = { "markdown", "tex" },
	-- Set wrap at 80 characters
	callback = function()
		vim.bo.textwidth = 80
		vim.wo.wrap = true
	end,
})
vim.api.nvim_create_autocmd("TermOpen", {
	group = file_type_override,
	pattern = "*",
	-- Don't show line numbers
	callback = function()
		vim.wo.number = false
		vim.wo.relativenumber = false
	end,
})

local dispatch_compiler = vim.api.nvim_create_augroup("DispatchCompiler", {})
vim.api.nvim_create_autocmd("FileType", {
	group = dispatch_compiler,
	pattern = "java",
	callback = function()
		vim.b.dispatch = "gradle build"
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = dispatch_compiler,
	pattern = "python",
	callback = function()
		vim.b.dispatch = "mypy %"
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = dispatch_compiler,
	pattern = "markdown",
	callback = function()
		vim.b.dispatch = "pandoc --pdf-engine=xelatex -f markdown % -o %.pdf"
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = dispatch_compiler,
	pattern = { "tex", "plaintex" },
	callback = function()
		vim.b.dispatch = "latexmk -pvc -pdflua %"
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = dispatch_compiler,
	pattern = { "sh", "bash" },
	command = ":compiler shellcheck",
})
vim.api.nvim_create_autocmd("FileType", {
	group = dispatch_compiler,
	pattern = "porth",
	command = ":compiler porth",
})

local template_files = vim.api.nvim_create_augroup("TemplateFiles", {})
vim.api.nvim_create_autocmd("BufNewFile", {
	group = template_files,
	pattern = { "*.py", "*.zsh" },
	callback = function(vals)
		local extension = vals["match"]:match "[^.]+$"
		-- Look for a file named skeleton.extension (ie. skeleton.py)
		-- in ~/.config/nvim/templates/ and read it into the current file
		vim.cmd("0r ~/.config/nvim/templates/skeleton." .. extension)
	end,
})
