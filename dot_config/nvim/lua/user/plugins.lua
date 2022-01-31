-- Bootstrap Packer if it isn't installed in the system
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap = nil
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

-- Plugins
return require("packer").startup({
	function(use)
		use("wbthomason/packer.nvim")

		-- Time tracking
		use("wakatime/vim-wakatime")
		use("tweekmonster/startuptime.vim")

		-- ColorScheme
		use({ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } })

		-- Colorizer
		use("norcalli/nvim-colorizer.lua")

		-- Jump hints
		use("unblevable/quick-scope")

		-- Align Text
		use("RRethy/nvim-align")

		-- Async commands
		use("tpope/vim-dispatch")

		-- Git integration
		use("tpope/vim-fugitive")

		-- nnoremap ... Functions in Lua
		use("svermeulen/vimpeccable")

		-- Language Server configuration
		use("neovim/nvim-lspconfig")
		use("onsails/lspkind-nvim")
		use("mfussenegger/nvim-jdtls") -- Java JDTLS support

		-- Completion Support
		use("hrsh7th/cmp-nvim-lsp") -- Language server hints
		use("hrsh7th/cmp-buffer") -- Words from the buffer
		use("hrsh7th/cmp-path") -- Path like strings (ie. /usr/bin/nvim)
		use("hrsh7th/cmp-cmdline") -- Commands completion
		use("saadparwaiz1/cmp_luasnip") -- Snippet support
		use("hrsh7th/nvim-cmp")
		use("jose-elias-alvarez/null-ls.nvim") -- Formatting support

		-- Snippet support
		use("L3MON4D3/LuaSnip")

		-- StatusLine
		use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })

		-- Filetype Highlighting
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
		use({ "baskerville/vim-sxhkdrc", ft = "sxhkdrc" })
		use({ "https://gitlab.com/DemonInTheCloset/porth-vim.git" })

		use({ "iamcco/markdown-preview.nvim", ft = "markdown", run = "yarn install" })

		-- Fuzzy find
		use({ "nvim-telescope/telescope.nvim", requires = { { "nvim-lua/plenary.nvim" } } })
		use("nvim-telescope/telescope-fzy-native.nvim") -- C binary for fzy

		--[[ Old FT higlights
        -- Plug 'godlygeek/tabular'
        use 'godlygeek/tabular'
        -- " Markdown Plugins
        -- Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
        use { 'plasticboy/vim-markdown', ft = 'markdown' }
        -- " Python Plugins
        -- Plug1 'psf/black', { 'branch': 'main', 'for': 'python' }
        use { 'psf/black', branch = 'main', ft = 'python' }
        -- " Haskell Plugins
        -- Plug 'neovimhaskell/haskell-vim', {'for': 'haskell'}
        use { 'neovimhaskell/haskell-vim', ft = 'haskell' }
        -- Plug 'twinside/vim-hoogle', {'for': 'haskell'}      " Hoolge search
        use {'twinside/vim-hoogle', ft = 'haskell'}
        -- " Rust Plugins
        -- Plug 'rust-lang/rust.vim', {'for': 'rust'}
        use { 'rust-lang/rust.vim', ft= 'rust'}
        -- " Simple X Hotkey Daemon
        -- Plug 'baskerville/vim-sxhkdrc', {'for': 'sxhkdrc'}
        -- " TOML Plugins
        -- Plug 'cespare/vim-toml', {'branch': 'main', 'for': 'toml'}
        use {'cespare/vim-toml', branch= 'main', ft= 'toml'}
        --]]

		-- Do bootstrap
		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		display = {
			open_fn = require("packer.util").float,
		},
	},
})
