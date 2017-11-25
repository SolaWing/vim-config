#!/bin/bash
File=${1:-/tmp/a.log}
nvim --headless --startuptime "$File.startup" --cmd 'prof start '"$File"' | prof func * | prof file *' -c 'profdel func * | profdel file * | q'
