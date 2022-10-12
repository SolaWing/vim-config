" Plug 'puremourning/vimspector'
Plug 'mfussenegger/nvim-dap'
" Plug 'suketa/nvim-dap-ruby'
Plug 'rcarriga/nvim-dap-ui'

nnoremap <space>dd :DapToggleBreakpoint<CR>
nnoremap <space>dc :DapContinue<CR>
nnoremap <space>dC :DapTerminate<CR>
nnoremap <space>dn :DapStepOver<CR>
nnoremap <space>ds :DapStepInto<CR>
nnoremap <space>do :DapStepOut<CR>
nnoremap <space>dl :DapShowLog<CR>
nnoremap <space>d<CR> :DapToggleRepl<CR>
" TODO: keymap binding "

autocmd mine User plug#end ++once luafile ~/.vim/bundle-config/debugger.lua
