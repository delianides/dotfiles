set autowrite noexpandtab tabstop=4 shiftwidth=4

map <C-n> :cn<CR>
map <C-m> :cp<CR>
nnoremap <leader>a :cclose<CR>

let g:go_textobj_include_function_doc = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 0
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_snippet_engine = "neosnippet"

let g:neomake_go_enabled_makers = ['golint']
