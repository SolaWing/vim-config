if exists("b:current_syntax")
  finish
endif

syn match pyFunc display "\<\w\+\s*("me=e-1 

hi def link pyFunc Identifier
