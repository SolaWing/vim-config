
if exists("loaded_sshHelper")
    finish
endif

let loaded_sshHelper = 1

command! -complete=dir -nargs=+ SSHMap call sshHelper#map(<f-args>)


""" vim: set sw=4 ts=4 sts=4 et foldmarker={,} foldlevel=0 foldmethod=marker:

