if exists("b:did_ftplugin")
  finish
endif

function! s:InsideCommentOrString()
  let l:pos = getpos('.')
  let l:syn_name = synIDattr(synID(l:pos[1], l:pos[2], 1), 'name')
  if l:syn_name =~? "string" || l:syn_name =~? "comment"
    return 1
  endif
  return 0
endfunction

function! ObjcBracketSurround()
  let l:savepos = getpos('.')
  let [l:rb, l:cb] = searchpairpos('{','','}','bW', 's:InsideCommentOrString()')
  call setpos('.', l:savepos)
  let [l:r, l:c] = searchpairpos('\m\[', '', '\]', 'bW', 's:InsideCommentOrString()' )
  if (l:r == 0 && l:c == 0) || (l:r < l:rb || (l:r == l:rb && l:c < l:cb))
    " not found match, not in a [] pair, or in a { pair }
    " should find the begin pos, suppose savepos is end pos
    " keyword or [] pair (not the form of dict[]) consider as identifier
    " when :identifier, is the parameter, should jump this identifier
    call setpos('.', l:savepos)
    while 1
      " search identifier, but not followed by :, or [] pair as entity
      let [l:r, l:c, l:m] = searchpos('\m\(\%([a-zA-Z0-9_.]\+\)\@>:\@!\)\|\(\]\)', 'bWp')
      " echom 'first' l:r l:c l:m
      if l:m < 2 " no match
        " beep
        norm! 
        return
      endif
      if s:InsideCommentOrString() | continue | endif
      if l:m == 3 " match the second pattern, search for pair []
        let [l:r, l:c] = searchpairpos('\m\[', '', '\]', 'bW', 's:InsideCommentOrString()' )
        if l:r == 0 && l:c == 0 | norm! 
          return
        else
          " check if the [] pair is part of dict[]
          norm! yh
          if @" =~ '\m[a-zA-Z0-9_\]]' | continue|endif
        endif
      endif
      " check if have a msg before
      let l:ret = search('\m\w\+:\s*\%#', 'bW', line('.'))
      if l:ret != 0 | continue | endif
      break
    endwhile

    noau norm! i[
    if l:r == l:savepos[1] | call cursor(l:savepos[1], l:savepos[2] + 1)
    else | call setpos('.', l:savepos)
    endif
    noau norm! a]h
  else " found in [] pair, direct add a [  ] surround []
    noau norm! a[
    let [l:r, l:c] = searchpairpos('\m\[', '', '\]', 'W', 's:InsideCommentOrString()' )
    noau norm! a ]h
  endif
endfunction

if !exists('g:objc_mb_map') | let g:objc_mb_map = ']]' | endif
exe 'inoremap <silent><buffer> ' . g:objc_mb_map . ' <esc>:call ObjcBracketSurround()<cr>a'

setl makeprg=xcodebuild\ -destination\ 'generic/platform=iOS'\ -configuration\ Debug
