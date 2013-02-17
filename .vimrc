call pathogen#infect()
call pathogen#helptags()
:filetype plugin on
:filetype plugin indent on
:syntax on
:set t_Co=256
:set number
:set ff=unix
:set modeline
:set tabstop=8 expandtab shiftwidth=4 softtabstop=4
:set smartindent
:set smarttab
:set enc=utf-8
:set mouse=nvc
:set cursorline
:set ai
:set nobackup
:set nowritebackup
:set noswapfile

" no bells
set noeb vb t_vb=

" xoria color scheme
:colo xoria256

" Set standart mapping
:let mapleader = ","

" Insert statusline from fugitive
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Nerdtree show bookmarks on startup
:let NERDTreeShowBookmarks=1

:let Tlist_Ctags_Cmd='/usr/local/bin/ctags'

" code(omni)
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType htmldjango.html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS


" Indent Guide
autocmd VimEnter * IndentGuidesEnable
:let g:indent_guides_guide_size = 1
:let g:indent_guides_start_level = 2

""" Key Mappings
" bind ctrl+space for omnicompletion
inoremap <Nul> <C-x><C-o>
imap <c-space> <C-x><C-o>

" Map Ctrl T to TagList
map <C-t> <esc>:TlistToggle<enter>


" Map Ctrl N to NerdTree
map <C-n> <esc>:NERDTreeToggle<enter>

"Surround Django Key Mappings
let b:surround_{char2nr("v")} = "{{ \r }}"
let b:surround_{char2nr("{")} = "{{ \r }}"
let b:surround_{char2nr("%")} = "{% \r %}"
let b:surround_{char2nr("b")} = "{% block \1block name: \1 %}\r{% endblock \1\1 %}"
let b:surround_{char2nr("i")} = "{% if \1condition: \1 %}\r{% endif %}"
let b:surround_{char2nr("w")} = "{% with \1with: \1 %}\r{% endwith %}"
let b:surround_{char2nr("f")} = "{% for \1for loop: \1 %}\r{% endfor %}"
let b:surround_{char2nr("c")} = "{% comment %}\r{% endcomment %}"

"""" Autocommands
if has("autocmd")
augroup vimrcEx
au!
	" smart indenting for python
	au FileType python set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
	autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
	set iskeyword+=.,_,$,@,%,#
	au FileType python set expandtab
	
	" kill calltip window if we move cursor or leave insert mode
	au CursorMovedI * if pumvisible() == 0|pclose|endif
	au InsertLeave * if pumvisible() == 0|pclose|endif
	augroup END
endif
""" Delete Whitespaces at the end of a line in Python
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
