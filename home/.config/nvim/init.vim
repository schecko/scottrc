set background=dark
set clipboard+=unnamedplus
set encoding=utf-8
set exrc " per-folder vimrc
set formatoptions=tj
set hidden
set modelines=0 " no need for showmode while using lightline
set nocompatible
set noshowmode
set number relativenumber
set scrolloff=10 " always keep lines visible above/below the cursor
set secure " for exrc
set shiftwidth=4
set showcmd
set splitbelow
set splitright
set tabstop=4
set textwidth=0 " disable newline insertion
set wildmenu
set wildmode=longest:full,full
set wrap

" backups
set backupdir=.backup/,~/.backup/,/tmp//
set directory=.swp/,~/.swp/,/tmp//
set undodir=.undo/,~/.undo/,/tmp//

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
" toggle search highlighting
nnoremap <silent><expr> <leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

inoremap jk <ESC>
tnoremap jk <c-\><c-n>
tnoremap <ESC> <c-\><c-n>

nnoremap <silent> <leader>bl :.w !bash<CR>
nnoremap <silent> <leader>ba :%w !bash<CR>

function! RemoveWhiteSpace()
	let saveCursor = getpos(".")
	let oldQuery = getreg("/")
	:%s/\s\+$//e
	call setpos(".", saveCursor)
	call setreg("/", oldQuery)
endfunction

augroup Vanilla
	autocmd!
	if has("win32")
		autocmd VimEnter * cd D:/src/
	endif

	" automatically start in insert mode when tabbed to a terminal
	autocmd BufWinEnter,WinEnter,TermOpen term://* startinsert
	autocmd FileType tex,latex let &makeprg="pdflatex %"

	" resize windows when the screen changes
	autocmd VimResized * exe "normal! \<c-w>="
	autocmd BufWritePre * :call RemoveWhiteSpace()
augroup END

call plug#begin('~/.config/nvim/plugged')
Plug 'dkprice/vim-easygrep'
Plug 'huawenyu/neogdb.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'mileszs/ack.vim'
Plug 'schecko/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-surround'
Plug 'valloric/youcompleteme'
Plug 'xolox/vim-easytags' "Depends on vim-misc!
Plug 'xolox/vim-misc'
call plug#end()

" vim-easygrep
let g:EasyGrepCommand = "ag"
let g:EasyGrepRecursive = 1

" lightline.vim
" some good colorschemes: molokai, solarized, darcula
let g:lightline = {
\	'colorscheme': 'molokai',
\	'active': {
\		'left': [
\ 			[ 'mode', 'paste' ],
\			[ 'filename', 'paste' ],
\			[ 'readonly', 'gitstatus' ]
\		]
\ 	},
\ 	'component_function': {
\		'gitstatus': 'FugitiveStatusline'
\ 	}
\}

" fzf.vim
function! DetectDotfilesFolder()
	let $FZF_DEFAULT_COMMAND = 'ag --ignore .git -l -g ""'
	" detect if the current folder contains this repo, if it does then
	" let fzf search for dotfiles as well as normal files.
	" autocmd folder specification does not work well for this case
	" as it only checks against subfolders. ie specifying ~/src/scottrc/*
	" will not work if nvim is opened with no arguments within ~/src/scottrc.
	if getcwd() =~? ".*scottrc.*"
		let $FZF_DEFAULT_COMMAND = $FZF_DEFAULT_COMMAND . ' --hidden'
	endif
endfunction
augroup AugmentFZF
	autocmd!
	autocmd VimEnter,DirChanged * :call DetectDotfilesFolder()
augroup END
nnoremap <silent> <expr> <c-p> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"

" tagbar
" ack.vim
let g:gackprg = "ag --vimgrep --hidden"

" nerdtree
function! DetectEmptyBuffer()
	return line("$") == 1 && getline(1) == ""
endfunction

augroup AugmentNerdTree
	autocmd!
	autocmd BufReadPre * :NERDTreeClose
augroup END
" syntastic
" vim-fugitive
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gb :GBlame<CR>
" TODO
" 	rebind - to s for "stage" in the staging page
" 	rebind = to d for "diff" in the staging page?
" vim-surround
" youcompleteme
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" vim-easytags
let g:easytags_async = 1

" vim-misc

