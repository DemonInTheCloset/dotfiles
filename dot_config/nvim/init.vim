" Plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovimhaskell/haskell-vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'twinside/vim-hoogle'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml', {'branch': 'main'}
Plug 'wakatime/vim-wakatime'

call plug#end()

" CoC.nvim Extensions
let g:coc_global_extensions=[
            \ 'coc-clang-format-style-options', 'coc-clangd', 'coc-highlight',
            \ 'coc-json', 'coc-markdown-preview-enhanced', 'coc-markdownlint',
            \ 'coc-pyright', 'coc-rust-analyzer', 'coc-snippets', 'coc-vimlsp',
            \ 'coc-webview'
            \ ]

" Setup environment
let g:python3_host_prog='~/.config/nvim/venv/bin/python'

" Enable Filetype detection and syntax Highlighting
syntax enable
filetype plugin indent on

" Appearance
set number relativenumber       " Show relative line numbers
set colorcolumn=80              " Color column 80
set cursorline                  " Highlight selected line
set nowrap                      " Long lines don't wrap
set signcolumn=number           " Merge line numbers with coc messages
let g:gruvbox_italic=1          " Allow italic font
let g:airline_powerline_fonts=1 " Allow powerline fonts for the status line
" In list mode show tabs and leading and trailing spaces
set listchars=tab:==>,trail:·,lead:·
" Colors
set termguicolors               " Allow Truecolor Support
colorscheme gruvbox             " Set colorscheme

set laststatus=2

" Global Tab and indentation settings
set smarttab                    " Tabs are smarter
set autoindent                  " Auto indent lines
set smartindent                 " Indentation is smarter
set expandtab                   " Change tabs to spaces
set tabstop=4                   " A Tab is 4 spaces
set softtabstop=0               " No softtabs
set shiftwidth=4                " An indent is 4 spaces

" augroups
augroup Tabsize
    autocmd FileType c setlocal tabstop=8
    autocmd FileType c setlocal shiftwidth=8
    autocmd FileType c setlocal noexpandtab
    autocmd FileType haskell setlocal tabstop=2
    autocmd FileType haskell setlocal shiftwidth=2
    autocmd FileType markdown setlocal shiftwidth=2
    autocmd FileType markdown setlocal shiftwidth=2
augroup END

augroup SymbolHighlight
    autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

augroup Templates
    autocmd BufNewFile *.py  0r ~/.config/nvim/templates/skeleton.py
    autocmd BufNewFile *.zsh 0r ~/.config/nvim/templates/skeleton.zsh
augroup END

augroup RemoveTrailingWhitespace
    autocmd BufWritePre *.md :%s/\s\+$//e
    autocmd BufWritePre *.py :%s/\s\+$//e
augroup END

" Search settings
set path=.,/usr/include,**
set wildmenu
set hlsearch ic                " Search ignores cases
set ignorecase

" Options needed by CoC
set updatetime=300              " Update every 300 ms
set timeoutlen=200              " Timeout after 200 ms
set hidden                      " TextEdit might fail otherwise
set shortmess+=c                " Don't pass messages to ins-completion-menu
set cmdheight=3                 " Give more space for messages
set nobackup                    " Some LSPs have problems with backups
set nowritebackup

" Filetype Specific Actions
augroup FiletypeBehaviour
    " Latex Preview
    autocmd FileType tex let b:dispatch = 'latexmk -pvc -pdf %'
augroup END 

let g:rustfmt_autosave = 1      " Format rust code on save

" Keybindings
" Enter jumps to line
nnoremap <CR> gg

" Make completions work like in VSCode
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
