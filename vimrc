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
	autocmd TerminalOpen * setlocal nonumber norelativenumber
endif

" STATUSLINE

function! GitBranch()
	return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
	let l:branchname = GitBranch()
	return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

" Section X
set statusline=%#MatchParen#
set statusline+=%(%{StatuslineGit()}\ %)
set statusline+=%#CursorLineNr#
set statusline+=%(\ %n\ %)
set statusline+=%#MatchParen#%(\ %)
" is paste set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

" Section Y
set statusline+=%#Folded#
" file status
set statusline+=%(\ %y\ %f\ %w%h%r%m%)
set statusline+=%=

" Section Z
set statusline+=%#MatchParen#%(\ %)
set statusline+=%#CursorLineNr#
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %(\ %4l:%2c\ %P\ %)
set statusline+=%#MatchParen#%(\ %)
set laststatus=2

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

"" Side panels
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'

"" UI
Plug 'morhetz/gruvbox'
"Plug 'vim-airline/vim-airline'

"" Languiges
Plug 'w0rp/ale'
Plug 'ervandew/supertab'

"" Lisp edit
"Plug 'kovisoft/paredit'
Plug 'vlime/vlime', {'rtp': 'vim/'}

"" Misc
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
"let g:airline_powerline_fonts = 1
"let g:Powerline_symbols = 'unicode'
"let g:airline#extensions#keymap#enabled = 0
"let g:airline_section_z = "YX:%4l/%2c %P/%L"
"let g:airline#extensions#xkblayout#enabled = 0
"let g:airline#extensions#whitespace#enabled = 0

" Syntatic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Rainbow parentheses
autocmd BufEnter * :RainbowParentheses
let g:rainbow#max_level = 64

" NerdTree
map <F3> :NERDTreeToggle<CR>
imap <F3> <C-O>:NERDTreeToggle<CR>

" TagBar
let NERDTreeShowHidden = 1
map <F4> :TagbarToggle<CR>
imap <F4> <C-O>:TagbarToggle<CR>
