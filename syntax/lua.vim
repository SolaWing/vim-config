if exists("b:current_syntax")
  finish
endif

syn keyword luaTodo contained NOTE
syn keyword luaSelf containedin=luaFunctionBlock contained self
syn match luaCustomParen display "[({]" contains=luaParen,luaTableBlock
syn match luaFunc display "\w\+\s*[({]" contains=luaCustomParen
"syn match luaIdentifier "\I\i*" contains=luaSelf

hi def SpecialKeyWord guifg=#8080ff
hi def CustomIdentifier guifg=#c0c0ff
hi def link luaSelf SpecialKeyWord
hi def link luaFunction Statement
hi Operator gui=bold cterm=bold

"hi def link luaFunc Label
"hi def link luaIdentifier CustomIdentifier
