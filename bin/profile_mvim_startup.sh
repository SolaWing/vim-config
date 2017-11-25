#!/bin/bash
File=${1:-/tmp/a.log}
mvim --startuptime "$File.startup" --cmd 'prof start '"$File"' | prof func * | prof file *'\
    -c 'set ut=100 | autocmd CursorHold * exe "profdel func * | profdel file * | q"'
