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
set exrc
set secure

set number
set relativenumber

set list
set listchars=tab:\ \ ,trail:·,nbsp:~
if v:version >= 802
	set listchars=tab:\ \ ,trail:·,lead:░,nbsp:~
endif

set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set autoindent
set smartindent

set wildmenu
set showcmd

set colorcolumn=80
set cursorline
set hlsearch

set splitright
set splitbelow

syntax enable

if v:version >= 800
	au TerminalOpen * setlocal nonumber norelativenumber
endif

" jump to the last position in file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"======
" KEYS
"======

" Retab file - F1
map <F1> :%retab! <CR>
set pastetoggle=<F5>

" Save - CTRL-S
" 1. Allow to use CTRL-S and CTRL-Q as keybinds
" 2. Restore default behaviour when leaving Vim.
silent !stty -ixon
autocmd VimLeave * silent !stty ixon
noremap  <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

" Go to definition - F12
map <F12> :sp <CR>:exec("tag ".expand("<cword>"))<CR>

" Go to definition in a vertical split - CTRL-F12
map <C-F12> :vs <CR>:exec("tag ".expand("<cword>"))<CR>

" Copy - CTRL-C
vnoremap <C-C> "*y

" Toggle line numbers - F8
map <F8> :set number! <CR> :set relativenumber! <CR>

map bn :bn<CR>
map bp :bp<CR>
map bd :b#<CR> :bd#<CR>
map bl :buffers<CR>

"=========
" PLUGINS
"=========

filetype plugin indent on
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

" Colors
Plug 'morhetz/gruvbox'

" Languiges
Plug 'w0rp/ale'
Plug 'ervandew/supertab'

" Misc
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
autocmd BufEnter * :RainbowParentheses
let g:rainbow#max_level = 64

"============
" STATUSLINE
"============

" status bar change colors
" 119 - LightGreen
" 241 - Grey39
" 231 - Grey100

function! StatuslineGit()
	let l:branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
	return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

hi statusline ctermfg=254 ctermbg=234

" INSERT
au InsertEnter * hi statusline ctermfg=119 ctermbg=234
au InsertLeave * hi statusline ctermfg=254 ctermbg=234

au CursorHold * hi statusline ctermfg=254 ctermbg=234
hi User1 ctermfg=245 ctermbg=233

" Config

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

set laststatus=2
set noshowmode
set statusline=
set statusline+=%0*%(\ %{toupper(g:currentmode[mode()])}\ %)
set statusline+=%0*%(%{&paste?'PASTE':''}\ %)
set statusline+=%1*%(\ %<%y\ %f\ %m%r%h%w\ %)
set statusline+=%=
set statusline+=%0*%(\ %{''.(&fenc!=''?&fenc:&enc).''}[%{&ff}]%)
set statusline+=%0*%(\ %04l/%02v\ (%3P/%L)\ %)

