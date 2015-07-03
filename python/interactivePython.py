from __future__ import print_function
import sys, re, subprocess, vim
from cStringIO import StringIO
# dict used as user interactive scope
user_env = {}
g = globals()

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

def interactiveScriptAnywhere(isReplace, isExec=None):
    """
    use input range as script input.
    @param isReplace: if output replace current input range or save in register
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
    if isReplace:
        vim.current.range[:] = [l.rstrip("\r\n") for l in out]
    else:
        s = out.read()
        # save in register, pyeval not use local scope in python
        vim.v0 = s
        vim.eval(r"setreg(v:register, PYEVAL('vim.v0'))")
        del vim.v0
        print(s)
    out.close()
