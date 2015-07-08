from __future__ import print_function
import sys, re, subprocess, vim
from cStringIO import StringIO
# dict used as user interactive scope
user_env = {
    "sys":sys,
    "re":re,
    "subprocess":subprocess,
    "vim":vim,
}
g = user_env
['user_options_store', 'getCFamilyToggleFile', 'UltiSnips_Manager', 'vimsupport', '__builtins__', 'GetCompletionsInner', 'utils', 'YouCompleteMe', 'results', '__package__', 'sys', 'base', 'u', 'module_path', '__name__', 'sourced_file', 'vim', 'os', '__doc__', 'ycm_state']

def interactivePython(s, t = 'single'):
    """
    eval python str like interactive console
    """
    # after compile, can prevent some error
    eval(compile(s, '<string>', t), g, user_env)

def captureOutput(func, *args):
    """
    return a file like object. best close it
    """
    oldSysout = sys.stdout
    out = StringIO()
    try:
        sys.stdout = out
        func(*args)
    except Exception as e:
        out.close()
        from traceback import print_exc
        print_exc(file = sys.stderr)
        raise
    finally:
        sys.stdout = oldSysout
    out.seek(0)
    return out

def escape(s, chars):
    buf = StringIO()
    for c in s:
        if c in chars: buf.write("\\")
        buf.write(c)
    s = buf.getvalue()
    buf.close()
    return s

def interactiveScriptAnywhere(output, isExec=None):
    """
    use input range as script input.
    @param output str: output place
        "output" : output
        "replace" : replace in current buf
        "append" : append after range
        "preview" : open in a preview window
        other: open a buffer named [other] and append there
    @param isExec: if is exec statement, default True when line > 1
    """
    r = vim.current.range
    instr = "\n".join(r).lstrip()
    # range = buffer[range.start:range.end]
    m = re.match('\s*[!?]', instr)
    if m:
        special = instr[m.end()-1]
        if special == '!':
            instr = instr[m.end():]
            # TODO: sh to exe cmd has some problem
            # for example: ag -g abc
            # fine in nvim, has problem in macvim
            out, _ = subprocess.Popen(instr, shell=True, stdin=None,
                                      stdout=subprocess.PIPE,
                                      stderr=subprocess.STDOUT) \
                .communicate()
            out = StringIO(out)
        elif special == '?':
            instr = "help(%s)"%(instr[m.end():])
            out = captureOutput(interactivePython, instr,'single')
    else:
        if isExec is None: isExec = len(r) > 1
        out = captureOutput(interactivePython, instr,\
                'exec' if isExec else 'single')
    if output == 'replace':
        vim.current.range[:] = [l.rstrip("\r\n") for l in out]
    elif output == 'append':
        r = vim.current.range
        r.append([l.rstrip("\r\n") for l in out], r.end)
    elif output == "output" or not output:
        s = out.read()
        # save in register, pyeval not use local scope in python
        vim.v0 = s
        vim.eval(r"setreg(v:register, PYEVAL('vim.v0'))")
        del vim.v0
        print(s)
    elif output == 'preview':
        name = "[python-preview]"
        vim.command(r"pedit +set\ bt=nofile %s"%escape(name,'\\ ['))
        win = None;
        for w in vim.current.tabpage.windows:
            if w.options['previewwindow']:
                win = w
                break
        win.buffer[:] = [l.rstrip("\r\n") for l in out]
    else:
        name = "[%s]"%output
        lastWin = vim.current.window;
        win = None;
        # in nvim, vim.windows return all windows
        for w in vim.current.tabpage.windows:
            if w.buffer.name.endswith(name):
                vim.current.window = w
                win = w
                break
        if win is None:
            vim.command(r"sp +set\ bt=nofile %s"%escape(name,' [\\'))
            win = vim.current.window
            if win.height > 10: win.height = 10

        win.cursor = (len(win.buffer),1) # move to last
        win.buffer.append([l.rstrip("\r\n") for l in out])
        vim.command(r'exe "norm! \<down>z\<CR>"')
        vim.current.window = lastWin
    out.close()
