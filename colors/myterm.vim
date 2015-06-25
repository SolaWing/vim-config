" modify on default
hi clear Normal
set bg&
hi clear

if exists("syntax_on")
  syntax reset
endif

hi Identifier ctermfg=blue

let colors_name = "myterm"
