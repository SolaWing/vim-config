PY << EOF
import os
def preview_markdown(name, s):
  if isinstance(s, bytes):
    s = s.decode('utf8')
  import subprocess, tempfile
  cssPath = os.path.expanduser("~/Sites/github-pandoc.css")
  tempdir = tempfile.gettempdir()
  tmpName = os.path.join(tempdir, "preview-{}.html".format(name))
  sp = subprocess.Popen(['pandoc', '-f', 'markdown+hard_line_breaks', '-o', tmpName, '--toc', '-c', cssPath]
                        , stdin=subprocess.PIPE, universal_newlines=True)
  (o, e) = sp.communicate(s)
  code = sp.wait()
  if code == 0:
      os.system("open '%s'"%tmpName)
  else:
      print( "error: ", e )
EOF
function! markdown#preview() range
exe printf('%d,%dPY << EOF', a:firstline, a:lastline)
preview_markdown(os.path.basename(vim.current.buffer.name) ,"\n".join(vim.current.range))
EOF
endfunction
