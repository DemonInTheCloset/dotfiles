" Plugins
call plug#begin('~/.config/nvim/plugged')

" Time tracking
Plug 'wakatime/vim-wakatime'

" NVim improvements
Plug 'morhetz/gruvbox'          " Colorscheme
Plug 'vim-airline/vim-airline'  " StatusLine
Plug 'tpope/vim-dispatch'       " Async commands
Plug 'tpope/vim-fugitive'       " Git integration

" Language specific features
Plug 'neoclide/coc.nvim', {'branch': 'release'}     " Completion & LSP engine

" Python Plugins
Plug 'psf/black', { 'branch': 'stable', 'for': 'python' }

" Haskell Plugins
Plug 'neovimhaskell/haskell-vim', {'for': 'haskell'}
Plug 'twinside/vim-hoogle', {'for': 'haskell'}      " Hoolge search

" Rust Plugins
Plug 'rust-lang/rust.vim', {'for': 'rust'}

" TOML Plugins
Plug 'cespare/vim-toml', {'branch': 'main', 'for': 'toml'}

call plug#end()

" CoC.nvim Extensions
let g:coc_global_extensions=[
            \ 'coc-clang-format-style-options', 'coc-clangd', 'coc-highlight',
            \ 'coc-json', 'coc-markdown-preview-enhanced', 'coc-markdownlint',
            \ 'coc-pyright', 'coc-rust-analyzer', 'coc-snippets', 'coc-vimlsp',
            \ 'coc-webview'
            \ ]

" Setup environment
let g:python3_host_prog='~/.config/nvim/.venv/bin/python'

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
" Folds
set foldmethod=syntax
" Statusbar
set laststatus=2                " Statusbar is always visible

" Global Tab and indentation settings
set smarttab                    " Tabs are smarter
set autoindent                  " Auto indent lines
set smartindent                 " Indentation is smarter
set expandtab                   " Change tabs to spaces
set tabstop=4                   " A Tab is 4 spaces
set softtabstop=0               " No softtabs
set shiftwidth=4                " An indent is 4 spaces

" augroups
augroup OpenFolds " Open folds when opening a file
    " silent! makes it so that it ignores the error: No Folds Found
    autocmd BufRead * silent! %foldopen!
augroup END

augroup Tabsize " Change default tab settings for specific files
    " C tab settings (Tabs are 8 spaces and don't expand tabs to spaces)
    autocmd FileType c setlocal tabstop=8
    autocmd FileType c setlocal shiftwidth=8
    autocmd FileType c setlocal noexpandtab
    " Haskell tab settings (Tabs are 2 spaces)
    autocmd FileType haskell setlocal tabstop=2
    autocmd FileType haskell setlocal shiftwidth=2
    " Markdown tab settings (Tabs are 2 spaces)
    autocmd FileType markdown setlocal tabstop=2
    autocmd FileType markdown setlocal shiftwidth=2
augroup END

augroup SymbolHighlight " Highlight all symbols with the same name
    autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

augroup Templates " File templates when creating files
    autocmd BufNewFile *.py  0r ~/.config/nvim/templates/skeleton.py
    autocmd BufNewFile *.zsh 0r ~/.config/nvim/templates/skeleton.zsh
augroup END

" Auto format files
augroup RemoveTrailingWhitespace
    autocmd BufWritePre *.md :%s/\s\+$//e
    autocmd BufWritePre *.py :%s/\s\+$//e
augroup END

function! ClangFormat()
    " let l:formatdiff = 1
    py3f /usr/share/clang/clang-format.py
endfunction

augroup RunFormatter " run formaters when writting to disk
    autocmd BufWritePre *.py :Black
    autocmd BufWritePre *.c call ClangFormat()
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

" Syntax Region Definition helper function
function! TextEnableCodeSnip(filetype,start,end,textSnipHl) abort
  let ft=toupper(a:filetype)
  let group='textGroup'.ft
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif
  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
  try
    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
  catch
  endtry
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif
  execute 'syntax region textSnip'.ft.'
  \ matchgroup='.a:textSnipHl.'
  \ keepend
  \ start="'.a:start.'" end="'.a:end.'"
  \ contains=@'.group
endfunction
