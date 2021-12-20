vim.cmd([[
" augroups
augroup OpenFolds " Open folds when opening a file
    " silent! makes it so that it ignores the error: No Folds Found
    autocmd BufRead * silent! %foldopen!
augroup END

augroup FTApperance " Change default tab settings for specific files
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
    autocmd FileType markdown setlocal wrap
augroup END

augroup TerminalMode " Settings for vim terminal mode
    autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

" augroup SymbolHighlight " Highlight all symbols with the same name
"     autocmd CursorHold * silent call CocActionAsync('highlight')
" augroup END

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

augroup SetCompiler " set compiler to run with vim-dispatch
    autocmd FileType java let b:dispatch = 'gradle build'
    autocmd FileType python let b:dispatch = 'mypy %'
    autocmd FileType markdown let b:dispatch = 'pandoc --pdf-engine=xelatex -f markdown % -o %.pdf'
    autocmd FileType tex let b:dispatch = 'latexmk -pvc -pdf %'
    autocmd FileType plaintex let b:dispatch = 'latexmk -pvc -pdf %'
augroup END
]])
