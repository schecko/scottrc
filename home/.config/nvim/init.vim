set nocompatible
filetype off
:let mapleader = " "

set modelines=0
set wrap
set textwidth=120
set showmode
set showcmd
set number relativenumber
set nu rnu
set encoding=utf-8
set tabstop=2
set shiftwidth=2
set splitbelow
set splitright

syntax on

call plug#begin('~/.config/nvim/plugged')
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'valloric/youcompleteme'
Plug 'tpope/surround'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-scripts/Conque-GDB'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags' "Depends on vim-misc!
Plug 'mileszs/ack.vim'
call plug#end()
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

set background=dark
colorscheme desert
let g:lightline = {
	\ 'colorscheme': 'solarized',
	\ }

set wildmenu
set wildmode=longest:full,full

" Terminal mode window navigation
tnoremap <M-h> <c-/\><c-n><c-w>h
tnoremap <M-j> <c-/\><c-n><c-w>j
tnoremap <M-k> <c-/\><c-n><c-w>k
tnoremap <M-l> <c-/\><c-n><c-w>l
" Normal mode window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>w

function! RemoveWhiteSpace()
	let saveCursor = getpos(".")
	let oldQuery = getreg("/")
	:%s/\s\+$//e
	call setpos(".", saveCursor)
	call setreg("/", oldQuery)
endfunction

noremap FileWritePre * :call RemoveWhiteSpace()

nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

let gackprg = "ag --vimgrep"
