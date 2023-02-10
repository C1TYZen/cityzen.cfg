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
set listchars=tab:\|\ ,trail:·,nbsp:~,eol:¬,lead:░

set tabstop=4
set shiftwidth=4
au BufRead,BufNewFile * set noexpandtab
au BufRead,BufNewFile *.rkt,*.scm,*.cl,*.py set expandtab
set autoindent
set smartindent

" Jump to the last position in file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

syntax enable

"===========
" FUNCTIONS
"===========

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
command! -nargs=+ Grep execute 'silent grep! --exclude-dir=.git --exclude={tags,ctags} --exclude=.* -Iirn <args> .' | copen
nmap <leader>g :Grep <C-R>=expand("<cword>")<CR><CR>

" Disable mouse
map <ScrollWheelUp> <nop>
map <S-ScrollWheelUp> <nop>
map <C-ScrollWheelUp> <nop>
map <ScrollWheelDown> <nop>
map <S-ScrollWheelDown> <nop>
map <C-ScrollWheelDown> <nop>
map <ScrollWheelLeft> <nop>
map <S-ScrollWheelLeft> <nop>
map <C-ScrollWheelLeft> <nop>
map <ScrollWheelRight> <nop>
map <S-ScrollWheelRight> <nop>
map <C-ScrollWheelRight> <nop>
set mouse=

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
" Plug 'w0rp/ale'
Plug 'ervandew/supertab'
Plug 'dhruvasagar/vim-table-mode'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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

"=====
" LUA
"=====

lua << EOF
	require 'plugins/lualine'
	require 'plugins/coc'
EOF
