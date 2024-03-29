execute pathogen#infect()

" prevents some delay when remapping <leader>
map , <leader>

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" let g:ycm_auto_hover = ''

let g:netrw_fastbrowse = 0      " fix for vim-vinegar that causes the netrw buffer to remain open

" nmap <leader>d <plug>(YCMHover)
" nmap <leader>r :YcmCompleter RefactorRename<Space>

filetype plugin indent on       " turns on filetype detection, load <filetype>plugin.vim, <filetype>indent.vim

colorscheme koehler
syntax enable                   " syntax coloring

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=a                     " Enable the use of mouse in all modes, need for terminal version
set mousefocus                  " move focus with mouse
set ttyfast                     " hints at a fast terminal connection
set lazyredraw                  " helps with rendering when running macros
set wildmenu                    " command completion
set wildmode=longest:full,full  " command completion settings
set showcmd                     " show the command you're typing in the bottom right corner
set showmatch                   " show matching bracket
set scrolloff=3                 " when scrolling up and down, try to keep at least 3 lines between the cursor and the edge of the screen
set ruler                       " turns on cursor coordinates in the file
set number                      " turns on the line numbers
set relativenumber              " turns on relative line numbers
set viminfo='100,f1             " save marks between reloading vim
set cursorline                  " highlight line with cursor

set autoread                    " reload the file under certain conditions of the file changing, like buffer updates and external commands
set autowrite                   " save the file when switching to another file
set autochdir                   " sets the vim context to the dir of the current buffer

set incsearch                   " highlight the next word as you're searching for it
set hlsearch                    " highlight all matching search patterns

set nobackup                    " disable temporary backup files
set nowritebackup               " disable temporary backup files
set noswapfile                  " turn off the swap file (the example.txt~ file)

set nowrap                      " turn off line wrapping
set formatoptions-=t            " default is tcq, removing t - http://vimdoc.sourceforge.net/htmldoc/change.html#fo-table
set formatoptions+=j            " default is tcq, adding j - http://vimdoc.sourceforge.net/htmldoc/change.html#fo-table
set textwidth=160               " maximum width of a line upon insertion
set linebreak                   " when auto inserting linebreaks, don't split words
set expandtab                   " convert any tabs entered into spaces
set autoindent                  " causes new lines enter to keep the same indentation as the previous line
set tabstop=2                   " how many spaces to insert in expandtab
set softtabstop=2               " treats certain operations on softtabs as and go back multiple spaces
set shiftwidth=2                " how many spaces when using << or >>
set shiftround                  " causes shifts to align to a multiple of the shift width
set backspace=indent,eol,start  " Backspace behavior

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrc
  autocmd!
augroup END

" Override tabs spacing settings for python files and run flake8 on save
autocmd vimrc Filetype python setlocal ts=4 sts=4 sw=4 makeprg=flake8
autocmd vimrc BufWritePost *.py silent make! <afile> | silent redraw!
autocmd vimrc QuickFixCmdPost [^l]* cwindow

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" REMAPPING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" useful shortcuts for navigating windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nmap <leader>b :bn<cr>:bd#<cr>
" nmap <leader>l :Black<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FIXES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fix issue with markdown errors showing in nvm-cmp documentation
hi link markdownError Normal
