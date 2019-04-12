au! BufNewFile,BufRead *.md setf markdown
" au! BufNewFile,BufRead *.fish setf sh
au! BufNewFile,BufRead *.mm setf objcpp
au! BufNewFile,BufRead *.wsd setf plantuml

" .h files can be C, Ch C++, ObjC or ObjC++.
" Set c_syntax_for_h if you want C, ch_syntax_for_h if you want Ch. ObjC is
" detected automatically.
au! BufNewFile,BufRead *.h			call s:FTheader()

func! s:FTheader()
  if match(getline(1, min([line("$"), 200])), '^#import\|@\(interface\|end\|class\)') > -1
    if exists("g:c_syntax_for_h")
      setf objc
    else
      setf objcpp
    endif
  elseif exists("g:c_syntax_for_h")
    setf c
  elseif exists("g:ch_syntax_for_h")
    setf ch
  else
    setf cpp
  endif
endfunc

" fix cpp detect for *.h, seems fname_case is wrong?
if has("fname_case")
    au! filetypedetect BufNewFile,BufRead *.H
endif
