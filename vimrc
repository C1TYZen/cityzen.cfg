"	▄████▄	 ██▓▄▄▄█████▓▓██   ██▓▒███████▒▓█████  ███▄    █	   ▄████▄	 █████▒ ▄████
"  ▒██▀ ▀█	▓██▒▓  ██▒ ▓▒ ▒██  ██▒▒ ▒ ▒ ▄▀░▓█	▀  ██ ▀█   █	  ▒██▀ ▀█  ▓██	 ▒ ██▒ ▀█▒
"  ▒▓█	  ▄ ▒██▒▒ ▓██░ ▒░  ▒██ ██░░ ▒ ▄▀▒░ ▒███   ▓██  ▀█ ██▒	  ▒▓█	 ▄ ▒████ ░▒██░▄▄▄░
"  ▒▓▓▄ ▄██▒░██░░ ▓██▓ ░   ░ ▐██▓░	▄▀▒   ░▒▓█	▄ ▓██▒	▐▌██▒	  ▒▓▓▄ ▄██▒░▓█▒  ░░▓█  ██▓
"  ▒ ▓███▀ ░░██░  ▒██▒ ░   ░ ██▒▓░▒███████▒░▒████▒▒██░	 ▓██░ ██▓ ▒ ▓███▀ ░░▒█░   ░▒▓███▀▒
"  ░ ░▒ ▒  ░░▓	  ▒ ░░		██▒▒▒ ░▒▒ ▓░▒░▒░░ ▒░ ░░ ▒░	 ▒ ▒  ▒▓▒ ░ ░▒ ▒  ░ ▒ ░    ░▒	▒
"	 ░	▒	 ▒ ░	░	  ▓██ ░▒░ ░░▒ ▒ ░ ▒ ░ ░  ░░ ░░	 ░ ▒░ ░▒	░  ▒	░		░	░
"  ░		 ▒ ░  ░		  ▒ ▒ ░░  ░ ░ ░ ░ ░   ░		 ░	 ░ ░  ░   ░			░ ░   ░ ░	░
"  ░ ░		 ░			  ░ ░		░ ░		  ░  ░		   ░   ░  ░ ░					░
"  ░					  ░ ░	  ░							   ░  ░

"========
"SETTINGS
"========

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

syntax enable

"====
"KEYS
"====

map <F1> :%retab! <CR>
"q-save
map <F2> :w! <CR>
"q-load
"map <F3> :e! <CR>
set pastetoggle=<F5>
"go to definition
map <F12> :sp <CR>:exec("tag ".expand("<cword>"))<CR>

"save
" 1. Allow to use Ctrl-s and Ctrl-q as keybinds
" 2. Restore default behaviour when leaving Vim.
silent !stty -ixon
autocmd VimLeave * silent !stty ixon

noremap  <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

"=======
"PLUGINS
"=======

filetype plugin indent on
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
Plug 'dhruvasagar/vim-table-mode'
Plug 'scrooloose/nerdtree'
Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline'
Plug 'majutsushi/tagbar'
Plug 'valloric/youcompleteme'
Plug 'vim-scripts/OmniCppComplete'
call plug#end()

"===============
"PLUGIN SETTINGS
"===============

colorscheme codedark

let g:airline_powerline_fonts = 1
let g:airline#extensions#keymap#enabled = 0
let g:airline_section_z = "\ue0a1:%l/%L Col:%c"
let g:Powerline_symbols='unicode'
let g:airline#extensions#xkblayout#enabled = 0
let g:airline#extensions#whitespace#enabled = 0

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

"===========
"PLUGIN KEYS
"===========

"NerdTree настройки
map <F3> :NERDTreeToggle<CR>
imap <F3> <C-O>:NERDTreeToggle<CR>
"TagBar настройки
map <F4> :TagbarToggle<CR>
imap <F4> <C-O>:TagbarToggle<CR>
