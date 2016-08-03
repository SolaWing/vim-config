#!/usr/bin/env python
# encoding: utf-8

import vim
import itertools
from io import StringIO

def ToUnicode( value ):
  if not value:
    return str()
  if isinstance( value, str ):
    return value
  if isinstance( value, bytes ):
    # All incoming text should be utf8
    return str( value, 'utf8' )
  return str( value )

def escape(s, chars):
    """ escape chars in str
    :rtype: str
    """
    buf = StringIO()
    for c in s:
        if c in chars: buf.write("\\")
        buf.write(c)
    s = buf.getvalue()
    buf.close()
    return s

def openPreviewWindow(name):
    """ open preview window with given name
    :param str name: preview window name
    :return: preview window
    """
    vim.command(r"pedit +set\ bt=nofile %s"%escape(name,'\\ ['))
    win = None;
    for w in vim.current.tabpage.windows:
        if w.options['previewwindow']:
            win = w
            break

    return win

def preview(content, name = '[Preview]'):
    """ show something in preview window
    :return: preview window
    """
    win = openPreviewWindow(name)
    win.buffer[:] = content.splitlines()
    return win

vim.preview = preview

def openOrReuseBuffer(name, newcmd='sp', maxHeight=10, allTab=False):
    """ reuse or open new buffer with name
    :param name: buffer name
    :param newcmd: when no buffer, cmd used to create one. default 'sp'
    :param maxHeight: max height when create. default 10
    :param allTab: if find buffer in allTab. default only current
    :return: open or reuse window
    """
    win = None
    if allTab: # search in all tab
        windows = itertools.chain.from_iterable(
            itertools.imap(lambda t:t.windows, vim.tabpages))
    else: # search in current tab
        windows = vim.current.tabpage.windows # search in current tab

    for w in windows:
        if w.buffer.name.endswith(name):
            vim.current.window = w
            win = w
            break

    if win is None:
        vim.command(r"%s %s"%(newcmd,escape(name,' [\\')))
        win = vim.current.window
        if (name[0] == '['):
            win.buffer.options['bt'] = 'nofile'
        if win.height > maxHeight: win.height = maxHeight

    return win

vim.openwin = openOrReuseBuffer

class Registers(object):

    """ vim Registers, operation by index or attr """
    def __getitem__(self, key):
        return vim.eval(r'@%s', key)
    def __setitem__(self, key, value):
        vim.tmp = value
        vim.eval(r"setreg('%s', PYEVAL('vim.tmp'))"%key)
        del vim.tmp
    def __delitem__(self, key):
        self.__setitem__(key, "")

    def __getattr__(self, name):
        return vim.eval(r'@%s', name)
    def __setattr__(self, name, value):
        vim.tmp = value
        vim.eval(r"setreg('%s', PYEVAL('vim.tmp'))"%name)
        del vim.tmp
    def __delattr__(self, name):
        self.__setattr__(name, '')

vim.registers = Registers()
