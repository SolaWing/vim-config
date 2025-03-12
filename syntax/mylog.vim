if exists("b:current_syntax")
  finish
endif
let b:current_syntax = "mylog"

syntax case ignore

syn match   log_date '\(Jan\|Feb\|Mar\|Apr\|May\|Jun\|Jul\|Aug\|Sep\|Oct\|Nov\|Dec\) [ 0-9]\d *' containedin=ALL
syn match   log_date '\d\{4}-\d\d-\d\d' containedin=ALL

syn match   log_time '\d\d:\d\d:\d\d\s*' containedin=ALL
syn match   log_time '\c\d\d:\d\d:\d\d\(\.\d\+\)\=\([+-]\d\d:\d\d\|Z\)' containedin=ALL

" 定义各日志级别的匹配规则
syntax match logDebug /\(trace\|debug\).*$/
syntax match logInfo /info.*$/
syntax match logWarning /warn.*$/
syntax match logError /\(error\|fatal\).*$/

" 定义高亮组（可根据需要调整颜色）
highlight link logDebug Comment
highlight link logWarning WarningMsg
highlight link logError ErrorMsg

hi link log_date 		Constant
hi link log_time 		Type
