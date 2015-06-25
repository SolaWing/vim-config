if exists("b:did_ftplugin")
  finish
endif

nnoremap <buffer> <Space>mp :<C-U>%call markdown#preview()<CR>
vnoremap <buffer> <Space>mp :call markdown#preview()<CR>
vnoremap <buffer> <Space>mo :<C-U>call system('open '.'<C-R>=GetVisualString()<CR>')<CR>
