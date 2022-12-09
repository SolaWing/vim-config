let g:submode_timeout = 0
let g:submode_keep_leaving_key = 1
Plug 'kana/vim-submode' " custom
autocmd mine VimEnter * call timer_start(1000, {-> s:submode_init() })
function! s:submode_init()
    function! SubmodeMap(name, mode, maps)
        for [enter, short, rhs, opt] in a:maps
            if !empty(enter)
                call submode#enter_with(a:name, a:mode, opt, enter, rhs)
            endif
            if !empty(short)
                call submode#map(a:name, a:mode, opt, short, rhs)
            endif
        endfor
    endfunction
    call SubmodeMap('Diff(nNwpou)', 'n',
                \ [['[c', 'N', '[czz', '']
                \ ,[']c', 'n', ']czz', '']
                \ ,['', 'w', '<C-W>w', '']
                \ ,['', 'p', 'dp', '']
                \ ,['', 'o', 'do', '']
                \ ,['', 'u', 'u', '']
                \ ,['', '<C-r>', '<C-r>', ''] ])
    call SubmodeMap('undo/redo', 'n',
                \ [['g-', '-', 'g-', '']
                \ ,['g+', '+', 'g+', '']
                \ ,['',   '=', 'g+', '']])
    call SubmodeMap('ChangeList', 'n',
                \ [['g;', ';', 'g;',           '']
                \ ,['g,', ',', 'g,',           '']
                \ ,['',   'L', ':changes<CR>', 'x']])
    call SubmodeMap('Navigation', 'n',
                \ [['gt',         't',     'gt',      '']
                \, ['gT',         'T',     'gT',      '']
                \, ['<C-W><C-J>', '<C-J>', '<C-W>j',  '']
                \, ['<C-W><C-K>', '<C-K>', '<C-W>k',  '']
                \, ['<C-W><C-H>', '<C-H>', '<C-W>h',  '']
                \, ['<C-W><C-L>', '<C-L>', '<C-W>l',  '']
                \, ['<C-W><C-W>', '<C-W>', '<C-W>w',  '']
                \, ['<C-W>W',     'W',     '<C-W>W',  '']
                \, ['<C-W>J',     'J',     '<C-W>J',  '']
                \, ['<C-W>K',     'K',     '<C-W>K',  '']
                \, ['<C-W>H',     'H',     '<C-W>H',  '']
                \, ['<C-W>L',     'L',     '<C-W>L',  '']
                \, ['<C-W>r',     'r',     '<C-W>r',  '']
                \, ['<C-W>R',     'R',     '<C-W>R',  '']
                \, ['<C-W>x',     'x',     '<C-W>x',  '']
                \, ['',           '_',     '<C-W>_',  '']
                \, ['',           '=',     '<C-W>=',  '']
                \, ['',           '\|',    '<C-W>\|', '']
                \, ['',           '<C-T>', '<C-W>T',  '']
                \, ['',           's',     '<C-W>s',  '']
                \, ['',           'v',     '<C-W>v',  '']
                \, ['',           'q',     '<C-W>q',  '']
                \, ['',           'c',     '<C-W>c',  '']
                \, ['',           'o',     '<C-W>o',  '']
                \, ['',           'f',     '<C-F>',   '']
                \, ['',           'b',     '<C-B>',   '']
                \, ['',           'd',     '<C-D>',   '']
                \, ['',           'u',     '<C-U>',   '']
                \ ])
endfunction
