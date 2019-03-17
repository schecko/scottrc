set nocompatible
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
set hidden
set wildmenu
set wildmode=longest:full,full
set background=dark

let mapleader = " "
let g:grepprg = "ag --nogroup --nocolor"

syntax on
filetype on
colorscheme desert

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

" add a newline without entering insert mode
nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

function! RemoveWhiteSpace()
	let saveCursor = getpos(".")
	let oldQuery = getreg("/")
	:%s/\s\+$//e
	call setpos(".", saveCursor)
	call setreg("/", oldQuery)
endfunction

autocmd BufWritePre * :call RemoveWhiteSpace()

call plug#begin('~/.config/nvim/plugged')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dkprice/vim-easygrep'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'valloric/youcompleteme'
Plug 'vim-scripts/Conque-GDB'
Plug 'xolox/vim-easytags' "Depends on vim-misc!
Plug 'xolox/vim-misc'
call plug#end()

" ctrlp.vim
	let g:ctrlp_user_command = 'ag %s -l --nocolor --ignore ".git" -g ""'
	function! DetectDotfilesFolder()
		" detect if the current folder contains this repo, if it does then
		" let ctrlp search for dotfiles as well as normal files.
		" autocmd folder specification does not work well for this case
		" as it only checks against subfolders. ie specifying ~/src/scottrc/*
		" will not work if nvim is opened with no arguments within the ~/src/scottrc.
		if getcwd() =~? ".*scottrc.*"
			let g:ctrlp_user_command = g:ctrlp_user_command . ' --hidden'
		endif
	endfunction
	autocmd VimEnter * :call DetectDotfilesFolder()
	let g:ctrlp_show_hidden = 1
	let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" vim-easygrep
let g:EasyGrepCommand = "ag"
let g:EasyGrepRecursive = 1

" lightline.vim
let g:lightline = { 'colorscheme': 'jellybeans' }

" fzf.vim
" tagbar
" ack.vim
let g:gackprg = "ag --vimgrep --hidden"

" nerdtree
" syntastic
" vim-fugitive
" vim-surround
" youcompleteme
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" Conque-GDB
" vim-easytags
let g:easytags_async = 1

" vim-misc

