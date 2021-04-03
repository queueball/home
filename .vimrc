execute pathogen#infect()

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#fnamemod = ':t'

let mapleader = ','
nmap <leader>d <plug>(YCMHover)
let g:ycm_auto_hover = ''
nmap <leader>r :YcmCompleter RefactorRename<Space>

" filetype off                    " superfluous with the next line
filetype plugin indent on       " turns on filetype detection, load <filetype>plugin.vim, <filetype>indent.vim

colorscheme torte
syntax enable                   " syntax coloring

" set nocompatible                " Not needed since this file exists
set mouse=a                     " Enable the use of mouse in all modes, need for terminal version
set mousefocus                  " move focus with mouse
set ttyfast                     " hints at a fast terminal connection
set lazyredraw                  " helps with rendering when running macros
" set noerrorbells                " turn off vim flashing on error, off by default
set wildmenu                    " command completion
set wildmode=longest:full,full  " command completion settings
set showcmd                     " show the command you're typing in the bottom right corner
" set showmode                    " display your current mode in the bottom left corner, default is on
set scrolloff=3                 " when scrolling up and down, try to keep at least 3 lines between the cursor and the edge of the screen
set ruler                       " turns on cursor coordinates in the file
set number                      " turns on the line numbers
set relativenumber              " turns on relative line numbers
set laststatus=2                " window always shows the status line

set autoread                    " reload the file under certain conditions of the file changing, like buffer updates and external commands
set autowrite                   " save the file when switching to another file
set autochdir                   " sets the vim context to the dir of the current buffer

set incsearch                   " highlight the next word as you're searching for it
set hlsearch                    " highlight all matching search patterns
" set magic                       " make regular expressions match grep, defaults to on

set nobackup                    " disable temporary backup files
set nowritebackup               " disable temporary backup files
set noswapfile                  " turn off the swap file (the example.txt~ file)
" set directory=.,$TEMP           " Set the swap directory location

set nowrap                      " turn off line wrapping
set formatoptions-=t            " default is tcq, removing t - http://vimdoc.sourceforge.net/htmldoc/change.html#fo-table
set linebreak                   " when auto inserting linebreaks, don't split words
set expandtab                   " convert any tabs entered into spaces
set autoindent                  " causes new lines enter to keep the same indentation as the previous line
set tabstop=2                   " how many spaces to insert in expandtab
set softtabstop=2               " treats certain operations on softtabs as and go back multiple spaces
set shiftwidth=2                " how many spaces when using << or >>
set shiftround                  " causes shifts to align to a multiple of the shift width
set backspace=indent,eol,start  " Backspace behavior
" set complete=.,w,b,u,U,t,i,d    " http://vimdoc.sourceforge.net/htmldoc/options.html#'complete', default is .,w,b,u,t,i
set textwidth=160               " maximum width of a line upon insertion

set foldcolumn=1                " column width to indicate folds

augroup vimrc
  autocmd!
augroup END

" Override tabs spacing settings for python files and run flake8 on save
autocmd vimrc Filetype python setlocal ts=4 sts=4 sw=4 makeprg=flake8
autocmd vimrc BufWritePost *.py silent make! <afile> | silent redraw!
autocmd vimrc QuickFixCmdPost [^l]* cwindow

" copy entire file to clipboard
nmap <leader>c :silent execute 'w !pbcopy'<CR>
