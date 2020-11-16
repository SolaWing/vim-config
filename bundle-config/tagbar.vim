let g:tagbar_autoclose = 1
let g:tagbar_sort = 0
let g:tagbar_type_objc = {
            \ 'ctagstype' : 'ObjectiveC',
            \ 'kinds'     : [
            \ 'i:interface',
            \ 'I:implementation',
            \ 'P:Protocol',
            \ 'm:Object_method',
            \ 'c:Class_method',
            \ 'v:Global_variable',
            \ 'F:Object field',
            \ 'f:function',
            \ 'p:property',
            \ 't:type_alias',
            \ 's:type_structure',
            \ 'e:enumeration',
            \ 'M:preprocessor_macro',
            \ ],
            \ 'sro'        : ' ',
            \ 'kind2scope' : {
            \ 'i' : 'interface',
            \ 'I' : 'implementation',
            \ 'P' : 'protocol',
            \ 's' : 'type_structure',
            \ 'e' : 'enumeration'
            \ },
            \ 'scope2kind' : {
            \ 'interface'      : 'i',
            \ 'implementation' : 'I',
            \ 'protocol'       : 'P',
            \ 'type_structure' : 's',
            \ 'enumeration'    : 'e'
            \ }
            \ }
let g:tagbar_type_objcpp = g:tagbar_type_objc
" let g:tagbar_type_rust = {
"             \ 'ctagstype' : 'Rust',
"             \ 'kinds' : [
"             \       'n:module:1:0',
"             \       's:struct:0:1',
"             \       'i:trait:0:1',
"             \       'c:implementation:0:0',
"             \       'f:function:0:1',
"             \       'g:enum:0:1',
"             \       't:type alias:0:1',
"             \       'v:global variable:0:1',
"             \       'M:macro:0:1',
"             \       'm:struct field:0:1',
"             \       'e:enum variant:0:1',
"             \       'F:method:0:1',
"             \ ],
"             \ 'sro' : '::',
"             \ 'kind2scope' : {
"             \ 'n' : 'module',
"             \ 's' : 'struct',
"             \ 'i' : 'interface',
"             \ 'c' : 'implementation',
"             \ 'f' : 'function',
"             \ 'g' : 'enum',
"             \ 'F' : 'method',
"             \ },
"             \ 'scope2kind' : {
"             \ 'module'        : 'n',
"             \ 'struct'        : 's',
"             \ 'interface'     : 'i',
"             \ 'implementation': 'c',
"             \ 'function'      : 'f',
"             \ 'enum'          : 'g',
"             \ 'method'        : 'F',
"             \ }
"             \}
Plug 'majutsushi/tagbar' , { 'on': 'TagbarToggle'}
nnoremap <F3> :TagbarToggle<CR>
