#!/usr/bin/env python
# encoding: utf-8

from __future__ import print_function, unicode_literals
from io import StringIO
import sys, re, subprocess, vim
import itertools
import myutil
# dict used as user interactive scope
user_env = {
    "sys":sys,
    "re":re,
    "subprocess":subprocess,
    "vim":vim,
    "p":print,
    "r":range,
    "it":itertools,
}
g = user_env

def interactivePython(s, t = 'single'):
    """
    eval python str like interactive console
    """
    # after compile, can prevent some error
    if t != 'exec': s = s + "\n"
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

interactiveShell = None
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
            global interactiveShell
            if interactiveShell is None:
                from os import path
                if path.exists('/usr/local/bin/fish'): interactiveShell = '/usr/local/bin/fish'
                else: interactiveShell = 'sh'
            # TODO: sh to exe cmd has some problem
            # for example: ag -g abc
            # fine in nvim, has problem in macvim
            out, _ = subprocess.Popen([interactiveShell, '-c', instr], shell=False, stdin=None,
                                      stdout=subprocess.PIPE,
                                      stderr=subprocess.STDOUT) \
                .communicate()
            out = StringIO(myutil.ToUnicode(out))
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
        myutil.preview(out.read(), name)
    else:
        name = "[%s]"%output
        lastWin = vim.current.window;
        win = myutil.openOrReuseBuffer(name)

        win.cursor = (len(win.buffer),1) # move to last
        win.buffer.append([l.rstrip("\r\n") for l in out])
        vim.command(r'exe "norm! \<down>z\<CR>"')
        vim.current.window = lastWin

    out.close()

def findAll(pat):
    """find all and may format according to fmt string"""
    s = "\n".join(vim.current.range)
    m = re.findall(pat , s, re.MULTILINE)
    if m:
        if isinstance(m[0], str):
            s = "\n".join(m)
        else:
            pat = vim.eval(r"inputdialog('input format pattern(group pass as args): ')")
            def fmt(pat,x):
                if pat:
                    if isinstance(x, str): return pat.format(x)
                    return pat.format(*x)
                else: return str(x)
            s = "\n".join(fmt(pat, x) for x in m)

        myutil.preview(s, '[python-output]')
