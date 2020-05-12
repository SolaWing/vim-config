if !exists("b:should_load_syntax")
    finish
endif
unlet b:should_load_syntax

syn match rubyAnnotationIdentifier contained /\w\+/ nextgroup=rubyAnnotationType skipwhite
syn region rubyAnnotationType contained start=/\[/ end=/\]/ oneline contains=rubyConstant
syn match rubyAnnotationTags display contained /@\%(yield\)\?\%(param\|return\|type\)/ nextgroup=rubyAnnotationIdentifier,rubyAnnotationType skipwhite

syn cluster rubyCommentSpecial add=rubyAnnotationTags
syn cluster rubyNotTop add=rubyAnnotationType,rubyAnnotationIdentifier

hi def link rubyAnnotationTags          SpecialComment
hi def link rubyAnnotationIdentifier	rubyIdentifier

