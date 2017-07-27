execute pathogen#infect()

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
set tabstop=4
set shiftwidth=4
set softtabstop=4
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
