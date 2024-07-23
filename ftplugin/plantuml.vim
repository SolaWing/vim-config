if exists("b:did_ftplugin")
  finish
endif

nnoremap <buffer> <LocalLeader>c :update <bar> Start! -wait=never plantuml -tsvg -quiet -nbthread auto -o /tmp/uml "%"
nnoremap <buffer> <LocalLeader>o :!open -a Firefox /tmp/uml/
nnoremap <buffer> <F1> :silent! !open -a Firefox http://plantuml.com/zh/commons<CR>

nnoremap <buffer> <LocalLeader>x <Cmd>call UMLSwitch0()<CR>

function! UMLSwitch0()
  s/\v(\w\S*)\s+("[^"]*"\s*)?([^-. ]*)([.-]+)([^-. ]*)\s+("[^"]*"\s*)?(%(\w|\.)+)/\=join([submatch(7), " ", submatch(6), UMLSwitch(submatch(5)), submatch(4), UMLSwitch(submatch(3)), " ", submatch(2), submatch(1)], "")
endfunction

function! UMLSwitch(text)
    if a:text[0] == "<"
        return a:text[1:] .. ">"
    elseif a:text[-1:] == ">"
        return "<" .. a:text[0:-2]
    endif
    return a:text
endfunction

let b:surround_47 = "/' \r '/"
