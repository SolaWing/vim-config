if exists("b:did_ftplugin")
  finish
endif

" Behaves just like objc
runtime! ftplugin/objc.vim ftplugin/objc_*.vim ftplugin/objc/*.vim
