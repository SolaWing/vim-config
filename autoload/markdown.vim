PY << EOF
import os, subprocess
def preview_markdown(path, s):
  name = os.path.basename(path)
  workdir = os.path.dirname(path)
  if isinstance(s, bytes):
    s = s.decode('utf8')

  cssPath = os.path.expanduser("~/Sites/github-pandoc.css")
  # import tempfile
  # tempdir = tempfile.gettempdir()
  # tempHeader = os.path.join(tempdir, "preview-{}.header".format(name))
  # with open(tempHeader, 'w') as f:
  #     f.write('<base href="{}" />'.format(path))

  # use current dir, so relative resource are ok. navigation also ok. but need to remove it or ignore it
  tmpName = os.path.join(workdir, ".preview-{}.html".format(name))
  sp = subprocess.Popen(['pandoc', '--standalone', '-f', 'markdown', '-t', 'html', '--toc', '-c', cssPath, '-o', tmpName]
                        , stdin=subprocess.PIPE, stderr=subprocess.PIPE, stdout=subprocess.PIPE, universal_newlines=True)
  (o, e) = sp.communicate(s)
  code = sp.wait()
  if code == 0:
      # o = o.replace("<head>", "<head>\n<base href='{}' />".format(path), 1)
      # with open(tmpName, "w") as f:
      #     f.write(o)
      
      os.system("open '%s'"%tmpName)
  else:
      print( "error", code, ":", e )
EOF
function! markdown#preview() range
exe printf('%d,%dPY << EOF', a:firstline, a:lastline)
preview_markdown(vim.current.buffer.name ,"\n".join(vim.current.range))
EOF
endfunction
