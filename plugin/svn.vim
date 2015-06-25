"{
if exists("loaded_svn")
    finish
endif
let loaded_svn = 1

command -nargs=* -complete=dir SVNCOMMIT call mysvn#commit(<q-args>)
command -nargs=* -complete=dir SVNREVERT call mysvn#revert(<q-args>)

""" vim: set sw=4 ts=4 sts=4 et foldmarker={,} foldlevel=0 foldmethod=marker:
"}
