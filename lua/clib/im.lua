-- [nfnl] Compiled from fnl/clib/im.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("config.deps")
local autoload = _local_1_["autoload"]
local ffi = autoload("ffi")
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
local _ascii_im = nil
local function ascii_im()
  if (nil == _ascii_im) then
    _ascii_im = CFTypeAutoRelease(carbon().TISCopyCurrentASCIICapableKeyboardInputSource())
  else
  end
  return _ascii_im
end
local function exit_insert()
  last_im = CFTypeAutoRelease(carbon().TISCopyCurrentKeyboardInputSource())
  return carbon().TISSelectInputSource(ascii_im())
end
local function enter_insert()
  if last_im then
    return carbon().TISSelectInputSource(last_im)
  else
    return nil
  end
end
local function enable_auto_im_switch()
  return vim.cmd("\n    autocmd mine InsertEnter * lua require('clib.im')['enter-insert']()\n    autocmd mine InsertLeave * lua require('clib.im')['exit-insert']()\n    ")
end
return {["enter-insert"] = enter_insert, ["exit-insert"] = exit_insert, ["enable-auto-im-switch"] = enable_auto_im_switch}
