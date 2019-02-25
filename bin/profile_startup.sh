#!/bin/bash
cmd="nvim --headless"
if [[ $0 == *mvim*  ]]; then
    cmd="mvim"
fi
File=${1:-/tmp/a.log}
shift
set -x
$cmd --startuptime "$File.startup" --cmd 'prof start '"$File"' | prof func * | prof file *'\
    -c 'call timer_start(300, {-> execute("profdel func * | profdel file * | q")}) ' "$@"
