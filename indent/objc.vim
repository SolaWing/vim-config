" Vim indent file
" Language:	Objective-C
" Maintainer:	Bjorn Winckler <bjorn.winckler@gmail.com>
" Last Change:	2012 Jan 01

" Ensure 'cpo' is set to Vim default values and restore later
let s:save_cpo = &cpo
set cpo&vim

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
   finish
endif
let b:did_indent = 1
"setlocal cindent

setl indentkeys=0{,0},:,0#,!^F,o,O,e,<:>

setl indentexpr=GetObjCIndentImproved()

" Top level statements which should not be indented, and which should not
" cause next (non-blank) line to be indented either.
let s:topLev = '^\s*@\%(class\|end\|implementation\|interface\|protocol\|\)\>'

function! s:GetWidth(line, regexp)
    let end = matchend(a:line, a:regexp)
    let width = 0
    let i = 0
    while i < end
      if a:line[i] != "\t"
        let width = width + 1
      else
        let width = width + &ts - (width % &ts)
      endif
      let i = i + 1
    endwhile
    return width
endfunction

function! GetObjCIndentImproved()
  let thisLine = getline(v:lnum)
  let prevnonblanknr = prevnonblank(v:lnum -1)
  let prevLine = getline(prevnonblanknr)

  if thisLine =~# s:topLev || prevLine =~# s:topLev
    return 0
  endif

  " If current line looks like an argument to a message dispatch, then line
  " up colon with previous line.  This will indent the second line so that
  " the colons line up in
  "
  "   [obj firstParameter:value
  "                paramB:value2];
  "
  " but it will not line up colons in
  "
  "   if ([obj something:here])
  "       [obj other:here];
  "
  " not indent : with this function, use clangFormat or Align plugin
  "
  "let thisColon = s:GetWidth(thisLine, ":")
  "if thisColon > 0 && prevLine !~# '[;{]'
  "  let prevColon = s:GetWidth(prevLine, ":")
  "  if prevColon > 0 && &textwidth > 0 && prevColon < &textwidth * 3 / 4
  "    " Try to align colons, always making sure line is indented at least
  "    " one shiftwidth more than the indentation at the beginning of the
  "    " message.  Avoids situations like this:
  "    "
  "    "     if ([obj a:x
  "    "  aLongParameter:y])
  "    "
  "    let [lnum,lcol] = searchpairpos('\[', '', '\]', 'b', 0,
  "          \ max([1, v:lnum - 10]))
  "    let minInd = &sw + (lnum > 0 ? indent(lnum) : 0)
  "    let alignedInd = prevColon - thisColon + s:GetWidth(thisLine, '\s\+')
  "    return alignedInd > minInd ? alignedInd : minInd
  "  endif
  "endif

  " Indent close pair to open pair
  if thisLine =~ '^\s*[]})]'
    norm! ^%
    return indent(".")
  endif

  " Indent a shiftwidth after {. cindent won't indent for {} in ()
  if prevLine =~ '{[^}]*$'
    return indent(prevnonblanknr) + &sw
  endif

  return cindent(v:lnum)
endfunction


" Restore 'cpo' options
let &cpo = s:save_cpo
unlet s:save_cpo
