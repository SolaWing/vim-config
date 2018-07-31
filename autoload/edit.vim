function! edit#toggleFullChar(...) range
    if a:0 > 0 && a:1
        echo "not implement"
    else
        '<,'>sm/\([,.]\)\s\?/\={',': '，', '.': '。'}[submatch(1)]/g
    endif
endfunction
