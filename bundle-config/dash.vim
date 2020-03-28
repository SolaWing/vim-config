Plug 'rizzatti/dash.vim', {'on': '<Plug>DashSearch'}
nmap <LocalLeader>K <Plug>DashSearch
let g:dash_map = {
            \ 'objc':   ['ios', 'c', 'manpages'],
            \ 'objcpp': ['ios', 'cpp', 'c', 'manpages'],
            \ 'lua':    ['lua','cocos2dx']
            \}
