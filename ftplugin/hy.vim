if exists("b:did_ftplugin")
  finish
endif

command -buffer Compile exe "!hy2py3 % > %:r.py" <bar> pedit %:r.py
nmap <LocalLeader>p :update <bar> exe "!hy2py3 % > %:r.py" <bar> pedit %:r.py<CR>
