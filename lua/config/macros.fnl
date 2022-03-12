(fn set-once [name ...]
   `(if (= nil ,name)
      (set ,name ,...)
      (do
        (print ,(.. "ignore exist val" (tostring name)))
        ,name)))

{:set-once set-once}
