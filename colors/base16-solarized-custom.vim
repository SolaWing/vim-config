if &background == 'light'
    " 8 - 15: red orange yellow green cyan blue violet magenta
    call base16#setup({
                \ 'gui': ['fdf6e3', 'eee8d5', '93a1a1', '839496', '657b83', '586e75', '073642', '002b36',
                \         'dc322f', 'cb4b16', 'b58900', '859900', '2aa198', '268bd2', '6c71c4', 'd33682'],
                \ 'cterm': [15, 7, 14, 12, 11, 10, "0", 8,
                \           1, 9, 3, 2, 6, 4, 13, 5],
                \ 'scheme_slug': 'solarized-custom'
                \ })
    if !has('gui_running')
        " hi EasyMotionTarget2FirstDefault
        hi EasyMotionTarget2First cterm=bold ctermfg=214
        " hi EasyMotionTarget2SecondDefault
        hi EasyMotionTarget2Second cterm=bold ctermfg=1

        " hi IndentGuidesOdd  guibg=red   ctermbg=7
        " hi IndentGuidesEven guibg=green ctermbg=7
    endif
else
    call base16#setup({ 'gui': ['002b36', '073642', '586e75', '657b83', '839496', '93a1a1', 'eee8d5', 'fdf6e3',
                \               'dc322f', 'cb4b16', 'b58900', '859900', '2aa198', '268bd2', '6c71c4', 'd33682'],
                \ 'cterm': [8, "0", 10, 11, 12, 14, 7, 15,
                \           1, 9, 3, 2, 6, 4, 13, 5],
                \ 'scheme_slug': 'solarized-custom'
                \ })
    if !has('gui_running')
        " hi EasyMotionTarget2FirstDefault
        hi EasyMotionTarget2First cterm=bold ctermfg=214
        " hi EasyMotionTarget2SecondDefault
        hi EasyMotionTarget2Second cterm=bold ctermfg=1

        " hi IndentGuidesOdd  guibg=red   ctermbg=8
        " hi IndentGuidesEven guibg=green ctermbg=0
    endif
endif
