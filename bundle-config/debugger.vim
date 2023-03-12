" Plug 'puremourning/vimspector'
Plug 'mfussenegger/nvim-dap'
" Plug 'suketa/nvim-dap-ruby'
Plug 'rcarriga/nvim-dap-ui'

nnoremap <space>dd <Cmd>DapToggleBreakpoint<CR>
nnoremap <space>dc <Cmd>DapContinue<CR>
nnoremap <space>dC <Cmd>DapTerminate<CR>
nnoremap <space>dn <Cmd>DapStepOver<CR>
nnoremap <space>ds <Cmd>DapStepInto<CR>
nnoremap <space>do <Cmd>DapStepOut<CR>
nnoremap <space>dl <Cmd>DapShowLog<CR>
nnoremap <space>d<CR> <Cmd>DapToggleRepl<CR>

autocmd mine User plug#end ++once luafile ~/.vim/bundle-config/debugger.lua
