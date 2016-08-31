au! BufNewFile,BufRead *.md setf markdown
" au! BufNewFile,BufRead *.fish setf sh
au! BufNewFile,BufRead *.mm setf objcpp

" fix cpp detect for *.h, seems fname_case is wrong?
if has("fname_case")
    au! filetypedetect BufNewFile,BufRead *.H
endif
