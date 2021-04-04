function! fold#cache(expr) range
    if !exists("b:foldcache")
        let b:foldcache = {}
    end
    if exists("g:keep_fold") " 临时禁用fold，用缓存, 主要是easymotion临时改buffer的情况
        if has_key(b:foldcache, v:lnum)
            return b:foldcache[v:lnum]
        end
    end
    let v = eval(a:expr)
    let b:foldcache[v:lnum] = v
    return v
endfunction
