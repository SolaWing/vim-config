if exists("b:did_ftplugin") | finish | endif

setl foldmethod=indent

setl shiftwidth=2
setl softtabstop=2
setl tabstop=4

" JXA doc:
" https://developer.apple.com/library/archive/releasenotes/InterapplicationCommunication/RN-JavaScriptForAutomation/Articles/OSX10-10.html#//apple_ref/doc/uid/TP40014508-CH109-SW2
" https://github.com/JXA-Cookbook/JXA-Cookbook?tab=readme-ov-file
nnoremap <buffer> <LocalLeader>r :!osascript -l JavaScript %<CR>

" nmap <buffer> <LocalLeader>f :update<bar>ALEFix<CR>
" nmap <buffer> <LocalLeader>gq :YcmCompleter Format<CR>
nmap <buffer> <LocalLeader><CR> <Plug>SlimeLineSend
xmap <buffer> <LocalLeader><CR> <Plug>SlimeRegionSend
