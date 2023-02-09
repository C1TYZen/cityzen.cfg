"  ▄████▄   ██▓▄▄▄█████▓▓██   ██▓▒███████▒▓█████  ███▄    █       ▄████▄    █████▒ ▄████
" ▒██▀ ▀█  ▓██▒▓  ██▒ ▓▒ ▒██  ██▒▒ ▒ ▒ ▄▀░▓█   ▀  ██ ▀█   █      ▒██▀ ▀█  ▓██   ▒ ██▒ ▀█▒
" ▒▓█    ▄ ▒██▒▒ ▓██░ ▒░  ▒██ ██░░ ▒ ▄▀▒░ ▒███   ▓██  ▀█ ██▒     ▒▓█    ▄ ▒████ ░▒██░▄▄▄░
" ▒▓▓▄ ▄██▒░██░░ ▓██▓ ░   ░ ▐██▓░  ▄▀▒   ░▒▓█  ▄ ▓██▒  ▐▌██▒     ▒▓▓▄ ▄██▒░▓█▒  ░░▓█  ██▓
" ▒ ▓███▀ ░░██░  ▒██▒ ░   ░ ██▒▓░▒███████▒░▒████▒▒██░   ▓██░ ██▓ ▒ ▓███▀ ░░▒█░   ░▒▓███▀▒
" ░ ░▒ ▒  ░░▓    ▒ ░░      ██▒▒▒ ░▒▒ ▓░▒░▒░░ ▒░ ░░ ▒░   ▒ ▒  ▒▓▒ ░ ░▒ ▒  ░ ▒ ░    ░▒   ▒
"   ░  ▒    ▒ ░    ░     ▓██ ░▒░ ░░▒ ▒ ░ ▒ ░ ░  ░░ ░░   ░ ▒░ ░▒    ░  ▒    ░       ░   ░
" ░         ▒ ░  ░       ▒ ▒ ░░  ░ ░ ░ ░ ░   ░      ░   ░ ░  ░   ░         ░ ░   ░ ░   ░
" ░ ░       ░            ░ ░       ░ ░       ░  ░         ░   ░  ░ ░                   ░
" ░                      ░ ░     ░                            ░  ░

"==========
" SETTINGS
"==========

set nocompatible
set encoding=utf-8
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
set exrc
set secure

set hlsearch
set incsearch
set ignorecase

set number
set relativenumber

set wildmenu
set showcmd

set colorcolumn=80
set cursorline

set splitright
set splitbelow

set list
set listchars=tab:\|\ ,trail:·,nbsp:~,eol:¬
if v:version >= 802
	set listchars+=lead:░
endif

set tabstop=4
set shiftwidth=4
au BufRead,BufNewFile * set noexpandtab
au BufRead,BufNewFile *.rkt,*.scm,*.cl,*.py set expandtab
set autoindent
set smartindent

if v:version >= 800
	au TerminalOpen * setlocal nonumber norelativenumber
endif

" Jump to the last position in file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

syntax enable

"===========
" FUNCTIONS
"===========

function! GetVisualSelection()
	let [line_start, column_start] = getpos("'<")[1:2]
	let [line_end, column_end] = getpos("'>")[1:2]
	let lines = getline(line_start, line_end)
	if len(lines) == 0
		return ''
	endif
	let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
	let lines[0] = lines[0][column_start - 1:]
	return join(lines, "\n")
endfunction

function! ExecOnTerm()
"	let term_buf filter(map(getbufinfo(), 'v:val.bufnr'), 'getbufvar(v:val, "&buftype") is# "terminal"')
	let term_buf = uniq(map(filter(getwininfo(), 'v:val.terminal'), 'v:val.bufnr'))
	if len(term_buf) == 0
		echo "You need to start TERM and REPL, дебил"
		return
	endif
	let code_slice = GetVisualSelection()
	call term_sendkeys(term_buf[0], code_slice)
	call term_sendkeys(term_buf[0], "\n")
endfunction

"======
" KEYS
"======

" Retab file
map <F1> :%retab! <CR>
set pastetoggle=<F5>

" Save
" 1. Allow to use CTRL-S and CTRL-Q as keybinds
" 2. Restore default behaviour when leaving Vim.
silent !stty -ixon
au VimLeave * silent !stty ixon
noremap  <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>
" Copy
vnoremap <C-C> "*y

" Toggle line numbers
map <F8> :set number! <CR> :set relativenumber! <CR>

map <F3> :TagbarToggle<CR>

" Buffers
map bn :bn<CR>
map bp :bp<CR>
map bd :bp<CR> :bd#<CR>
map bl :buffers<CR>

" !!! For lisp expressions, first you need to start REPL in terminal !!!
vnoremap <silent> <leader>ev :<C-U>call ExecOnTerm()<CR>

" opens search results in a window and highlight the matches
" example 'Grep --include \*.c printf .'
command! -nargs=+ Grep execute 'grep! -Iirn <args> .' | copen
nmap <leader>g :Grep <C-R>=expand("<cword>")<CR><CR>

"=========
" PLUGINS
"=========

filetype plugin indent on
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	au VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

Plug 'morhetz/gruvbox'
Plug 'w0rp/ale'
Plug 'ervandew/supertab'
Plug 'dhruvasagar/vim-table-mode'
Plug 'junegunn/rainbow_parentheses.vim'

call plug#end()

"=================
" PLUGIN SETTINGS
"=================

" Gruvbox
set background=dark
colorscheme gruvbox

" Rainbow parentheses
au BufEnter * :RainbowParentheses
let g:rainbow#max_level = 64

"============
" STATUSLINE
"============

let g:currentmode={
	\ 'n'      : 'Normal',
	\ 'no'     : 'Normal·Operator Pending',
	\ 'v'      : 'Visual',
	\ 'V'      : 'V·Line',
	\ "\<C-V>" : 'V·Block',
	\ 's'      : 'Select',
	\ 'S'      : 'S·Line',
	\ "\<C-S>" : 'S·Block',
	\ 'i'      : 'Insert',
	\ 'R'      : 'Replace',
	\ 'Rv'     : 'V·Replace',
	\ 'c'      : 'Command',
	\ 'cv'     : 'Vim Ex',
	\ 'ce'     : 'Ex',
	\ 'r'      : 'Prompt',
	\ 'rm'     : 'More',
	\ 'r?'     : 'Confirm',
	\ '!'      : 'Shell',
	\ 't'      : 'Terminal'
	\}

" status bar change colors
" 119 - LightGreen
" 241 - Grey39
" 231 - Grey100

function! StatuslineGit()
	let l:branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
	return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

hi statusline ctermfg=254 ctermbg=234
hi User1 ctermfg=245 ctermbg=237

au InsertEnter * hi statusline ctermfg=119 ctermbg=234
au InsertLeave * hi statusline ctermfg=254 ctermbg=234
au CursorHold * hi statusline ctermfg=254 ctermbg=234

set laststatus=2
set noshowmode
set statusline=
set statusline+=%0*%(\ %{toupper(g:currentmode[mode()])}\ %)
set statusline+=%0*%(%{&paste?'PASTE':''}\ %)
set statusline+=%1*%(\ %<%y\ %f\ %m%r%h%w\ %)
set statusline+=%=
set statusline+=%0*%(\ %{''.(&fenc!=''?&fenc:&enc).''}[%{&ff}]%)
set statusline+=%0*%(\ %04l/%02v\ (%3P/%L)\ %)

