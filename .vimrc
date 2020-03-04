execute pathogen#infect()

filetype off
filetype plugin indent on

set runtimepath^=~/.vim/bundle/ctrlp.vim

colorscheme torte
syntax enable                   " Keep my color settings

set mouse=a
set nocompatible
set nobackup
set nowritebackup
set nowrap
set noswapfile

set showcmd
set showmode
set scrolloff=3
set linebreak
set ttyfast
set lazyredraw
set noerrorbells
set ruler

set autoread
set autowrite
set autochdir

set incsearch
set hlsearch

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set shiftround
set autoindent
set wildmenu

set number
set relativenumber

set backspace=indent,eol,start  " Backspace behavior in insert mode
set directory=.,$TEMP           " Set the swap directory location

set complete=.,w,b,u,U,t,i,d    " current buffer, buffers in other windows, loaded buffers, unloaded bufferes, ???, tags, included files, ???

set magic                       " make regular expressions match grep

set mousefocus
set laststatus=2

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#fnamemod = ':t'

set textwidth=160
set fo-=t

set foldcolumn=1

autocmd Filetype python setlocal ts=4 sts=4 sw=4
" autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
" autocmd Filetype scss setlocal ts=2 sts=2 sw=2
" autocmd Filetype *.hbs setlocal ts=2 sts=2 sw=2
