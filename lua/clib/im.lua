local _2afile_2a = "/Users/wang/.config/nvim/fnl/clib/im.fnl"
local _2amodule_name_2a = "clib.im"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local autoload = (require("aniseed.autoload")).autoload
local ffi = autoload("ffi")
do end (_2amodule_locals_2a)["ffi"] = ffi
local last_im = nil
local function CFTypeAutoRelease(v)
  return ffi.gc(v, ffi.C.CFRelease)
end
local _carbon = nil
local function carbon()
  if (nil == _carbon) then
    _carbon = ffi.load("/System/Library/Frameworks/Carbon.framework/Carbon")
    ffi.cdef("\n            typedef signed int                      SInt32;\n            typedef SInt32                          OSStatus;\n            typedef const void * CFTypeRef;\n\n            CFTypeRef CFRetain(CFTypeRef cf);\n            void CFRelease(CFTypeRef cf);\n\n            typedef void*        TISInputSourceRef;\n            extern TISInputSourceRef TISCopyCurrentKeyboardInputSource(void);\n            extern OSStatus TISSelectInputSource(TISInputSourceRef inputSource);\n            extern TISInputSourceRef TISCopyCurrentASCIICapableKeyboardInputSource(void);\n            ")
  else
  end
  return _carbon
end
_2amodule_2a["carbon"] = carbon
local _ascii_im = nil
local function ascii_im()
  if (nil == _ascii_im) then
    _ascii_im = CFTypeAutoRelease(carbon().TISCopyCurrentASCIICapableKeyboardInputSource())
  else
  end
  return _ascii_im
end
_2amodule_2a["ascii-im"] = ascii_im
local function exit_insert()
  last_im = CFTypeAutoRelease(carbon().TISCopyCurrentKeyboardInputSource())
  return carbon().TISSelectInputSource(ascii_im())
end
_2amodule_2a["exit-insert"] = exit_insert
local function enter_insert()
  if last_im then
    return carbon().TISSelectInputSource(last_im)
  else
    return nil
  end
end
_2amodule_2a["enter-insert"] = enter_insert
local function enable_auto_im_switch()
  return vim.cmd("\n    autocmd mine InsertEnter * lua require('clib.im')['enter-insert']()\n    autocmd mine InsertLeave * lua require('clib.im')['exit-insert']()\n    ")
end
_2amodule_2a["enable-auto-im-switch"] = enable_auto_im_switch
return _2amodule_2a