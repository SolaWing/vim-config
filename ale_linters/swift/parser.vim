
function! ale_linters#swift#parser#GetCommand(buffer) abort

py3 << EOF
import vim, ale_swift_compiler
v = ale_swift_compiler.ale_swift_parser_get_command(vim.buffers[int(vim.eval("a:buffer"))].name)
EOF

let g:v = PYEVAL("v")
return g:v

endfunction

call ale#linter#Define('swift', {
\   'name':             'parser',
\   'output_stream':    'stderr',
\   'executable':       'swift',
\   'command_callback': 'ale_linters#swift#parser#GetCommand',
\   'callback':         'ale_linters#swift#swiftpm#Handle',
\   'read_buffer':      1,
\})
