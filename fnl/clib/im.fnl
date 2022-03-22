(module clib.im
  {autoload {: ffi}})

; lazy load state
(var last-im nil)

(fn CFTypeAutoRelease [v]
  (ffi.gc v ffi.C.CFRelease))

(var _carbon nil)
(defn carbon []
  (when (= nil _carbon)
    (set _carbon (ffi.load "/System/Library/Frameworks/Carbon.framework/Carbon"))
    (ffi.cdef "
            typedef signed int                      SInt32;
            typedef SInt32                          OSStatus;
            typedef const void * CFTypeRef;

            CFTypeRef CFRetain(CFTypeRef cf);
            void CFRelease(CFTypeRef cf);

            typedef void*        TISInputSourceRef;
            extern TISInputSourceRef TISCopyCurrentKeyboardInputSource(void);
            extern OSStatus TISSelectInputSource(TISInputSourceRef inputSource);
            extern TISInputSourceRef TISCopyCurrentASCIICapableKeyboardInputSource(void);
            "))
  _carbon)

(var _ascii-im nil)
(defn ascii-im []
  (when (= nil _ascii-im)
    (set _ascii-im (CFTypeAutoRelease ((. (carbon) "TISCopyCurrentASCIICapableKeyboardInputSource")))))

  _ascii-im)

;; IM hook and autoswitch
(defn exit-insert []
  (set last-im (CFTypeAutoRelease ((. (carbon) "TISCopyCurrentKeyboardInputSource"))))
  ((. (carbon) "TISSelectInputSource") (ascii-im)))

(defn enter-insert []
  (when last-im
    ((. (carbon) "TISSelectInputSource") last-im)))

; FIXME: 终端下不管用，虽然看着输入法是切换了..
(defn enable-auto-im-switch []
  (vim.cmd "
    autocmd mine InsertEnter * lua require('clib.im')['enter-insert']()
    autocmd mine InsertLeave * lua require('clib.im')['exit-insert']()
    "))

