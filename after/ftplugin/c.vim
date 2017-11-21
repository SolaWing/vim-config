" setlocal comment=sO:* -,mO:*  ,exO:*/,s1:/*,mb:*,ex:*/,://

" remove middle * for /**/ comment
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,://
setlocal commentstring=//\ %s
