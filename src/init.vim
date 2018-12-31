set nocompatible
filetype off

set modelines=0
set wrap
set textwidth=120
set showmode
set showcmd
set number relativenumber
set nu rnu
set encoding=utf-8

syntax on

call plug#begin('~/.config/nvim/plugged')
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'valloric/youcompleteme'
call plug#end()

set background=dark
let g:lightline = {
	\ 'colorscheme': 'solarized', 
	\ }

" Terminal mode window navigation
tnoremap <M-h> <c-/\><c-n><c-w>h
tnoremap <M-j> <c-/\><c-n><c-w>j
tnoremap <M-k> <c-/\><c-n><c-w>k
tnoremap <M-l> <c-/\><c-n><c-w>l
" Normal mode window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
