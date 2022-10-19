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
set listchars=tab:\ \ ,trail:·,lead:░,nbsp:~

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

map gn :bn<CR>
map gp :bp<CR>
map gd :bp<CR> :bd#<CR>

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
"" Side panels
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'

"" Design
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'

"" Languages
Plug 'vlime/vlime', {'rtp': 'vim/'}
Plug 'w0rp/ale'
"Lisp edit
Plug 'kovisoft/paredit'

"" Misc
Plug 'ervandew/supertab'
Plug 'dhruvasagar/vim-table-mode'
Plug 'farmergreg/vim-lastplace'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'jiangmiao/auto-pairs'
call plug#end()

"=================
" PLUGIN SETTINGS
"=================

" Gruvbox
set background=dark
colorscheme gruvbox

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#keymap#enabled = 0
let g:airline_section_z = "L/N:%l/%L Col:%c"
let g:Powerline_symbols = 'unicode'
let g:airline#extensions#xkblayout#enabled = 0
let g:airline#extensions#whitespace#enabled = 0

" Syntatic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Rainbow parentheses
au BufEnter * :RainbowParentheses
let g:rainbow#max_level = 32

" NerdTree
map <F3> :NERDTreeToggle<CR>
imap <F3> <C-O>:NERDTreeToggle<CR>

" TagBar
map <F4> :TagbarToggle<CR>
imap <F4> <C-O>:TagbarToggle<CR>

