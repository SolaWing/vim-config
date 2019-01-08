#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import re
import vim
from myutil import ToBytes, EscapeForVim

def index_pair(s, at):
    """ return index of pair for at chat, -1 if not found
    :param str s: search string
    """
    if isinstance(s, bytes):
        pairs = b"()[]{}"
    else:
        pairs = "()[]{}"
    i = pairs.find(s[at])
    if i == -1: return -1

    forward = i % 2 == 0
    cur = pairs[i]
    target = pairs[ i + (1 if forward else -1) ]

    deep = 0
    i = at
    nestcount = 0
    if forward:
      i+=1
      while True:
        end = s.find(target, i)
        if end == -1: return -1
        # search back to check nest pair
        nestcount += s.count(cur, i, end)
        if nestcount == 0: # all balanced, return
            return end
        else:
            nestcount -= 1 # cosume one
            i = end + 1
    else:
      while True:
        end = s.rfind(target, 0, i)
        if end == -1: return -1
        # search back to check nest pair
        nestcount += s.count(cur, end, i)
        if nestcount == 0: # all balanced, return
            return end
        else:
            nestcount -= 1 # cosume one
            i = end

def expand_closure(curry=True):
  """
  should select expanding closure before call this method, expand closure param according to swift rules

  expand closure like: `label: (params) throws -> return`
  label, throws is optional
  """

  try:
    buf = vim.current.buffer
    begin_pos = buf.mark("<") # (1,0) byte base
    end_pos = buf.mark(">")
    is_single_line = begin_pos[0] == end_pos[0]
    if not is_single_line: return

    line = ToBytes(buf[begin_pos[0] -1]) # type: bytes
    if len(line) <= end_pos[1] + 1: return # 不能选中到行末, expand的closure后面应该有`,)`等分隔符

    if line[begin_pos[1]] == b'(': # start a closure and no label
        closure_begin = begin_pos[1]
    else: # start with a label
        closure_begin = line.find(b"(", begin_pos[1])
        if closure_begin == -1: return
    closure_param_end = index_pair(line, closure_begin)
    if closure_param_end == -1: return

    closure_params = line[closure_begin+1:closure_param_end].decode()
    closure_return_parts = line[closure_param_end+1: end_pos[1] + 1].decode()
    # ignore `-> Void`
    if closure_return_parts and re.match(r"^\s*(throws )?->\s*(Void|\(\))\s*$", closure_return_parts):
        closure_return_parts = ""
    template = "{ (${1:%s})%s in\n\t$0\n}"%( closure_params, closure_return_parts )

    # find replace range
    next_char = line[end_pos[1]+1]
    if next_char == ord(")") and curry: # curry last closure
        comma = line.rfind(b",", 0, begin_pos[1])
        open_paren = line.rfind(b"(", 0, begin_pos[1])
        replace_begin = max(comma, open_paren)
        if replace_begin == -1: return

        replace_end = end_pos[1] + 1
        if replace_begin == open_paren:
            template = " " + template
        else:
            template = ") " + template
    else:
        replace_begin = begin_pos[1]
        replace_end = end_pos[1]

    will_replace = line[replace_begin: replace_end+1].decode()

    # only side effect: move cursor to replace_end, and expand by UltiSnips
    vim.current.window.cursor = (end_pos[0], replace_end+1)
    vim.eval("UltiSnips#Anon('{}', '{}', '', 'i')".format(
        *map(EscapeForVim, (template, will_replace))))

    return True
  except Exception as e:
      import traceback
      traceback.print_exc()
      return
