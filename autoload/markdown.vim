PY << EOF
import os
def preview_markdown(s):
  if isinstance(s, str):
    s = s.decode('utf8')
  templatePath = os.path.expanduser("~/Sites/markdown.template")
  import markdown
  html = markdown.markdown(s, extensions=['markdown.extensions.tables'])
  with open(templatePath) as f:
    template = f.read()
    s = template.replace("{{placeholder}}", html)
  if isinstance(s, unicode):
    s = s.encode('utf8')
  import tempfile
  with tempfile.NamedTemporaryFile(suffix = '.htm',delete = False) as out:
    out.write(s)
    out.close()
  os.system("open '%s'"%out.name)
EOF
function! markdown#preview() range
exe printf('%d,%dPY << EOF', a:firstline, a:lastline)
preview_markdown("\n".join(vim.current.range))
EOF
endfunction
