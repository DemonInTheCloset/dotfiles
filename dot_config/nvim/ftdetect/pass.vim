au BufNewFile,BufRead,VimEnter
            \ /dev/shm/pass.?*/?*.txt
            \,$TMPDIR/pass.?*/?*.txt
            \,/tmp/pass.?*/?*.txt
            \ setfiletype pass
