;; fennel-ls: macro-file
;; [nfnl-macro]

(fn call [...]
  "simple macro to use with ->, to call the thread value"
  (list ...))

(fn set-once [name ...]
   `(if (= nil ,name)
      (set ,name ,...)
      (do
        (print ,(.. "ignore exist val" (tostring name)))
        ,name)))

(fn MT [a t]
  "merge literal array and dict to one table"
  (for [i 1 (length a) 1]
    (table.insert t (. a i)))
  t)

{: set-once
 : call
 : MT}

