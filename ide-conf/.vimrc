" Pathogen load
filetype off

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on

" show tabs and trailing whitespaces
set list listchars=tab:\|_,trail:.


" makes vimgrep really slow
let g:pymode_folding = 0
let g:pymode_rope = 1
let g:pymode_rope_completion = 1
let g:pymode_python = 'python3'
let g:pymode_lint_checkers = ['pep8', 'mccabe', 'pyflakes', 'pylint']
let g:pymode_lint_ignore = ["E501" , "C0301"]

"let g:pymode_debug = 1

vnoremap <expr> // 'y/\V'.escape(@",'\').'<CR>'

autocmd FileType yaml setlocal ai ts=2 sw=2 et
autocmd FileType javascript setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType javascriptreact setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab

highlight! link DiffText MatchParen

:nmap <F3> :vimgrep // pyanaconda/**/*.py anaconda.py<left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>
:nmap <F4> :vimgrep /<C-R><C-W>/ pyanaconda/**/*.py anaconda.py<left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>
:nmap <F5> :vimgrep // src/**/*.js src/**/*.jsx<left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>
:nmap <F6> :vimgrep /<C-R><C-W>/ src/**/*.js src/**/*.jsx<left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>

:nmap <F7> :vimgrep /<C-R><C-W>/ test/check-* test/helpers/* <left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>

"let NERDTreeShowHidden=1
