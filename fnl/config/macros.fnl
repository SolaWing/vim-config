(fn call [...]
  "simple macro to use with ->, to call the thread value"
  (list ...))
(fn set-once [name ...]
   `(if (= nil ,name)
      (set ,name ,...)
      (do
        (print ,(.. "ignore exist val" (tostring name)))
        ,name)))

{: set-once}
