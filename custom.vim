" prevents some delay when remapping <leader>
map , <leader>

filetype plugin indent on             " turns on filetype detection, load <filetype>plugin.vim, <filetype>indent.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=a                           " Enable the use of mouse in all modes, need for terminal version
set mousefocus                        " move focus with mouse
set lazyredraw                        " helps with rendering when running macros
set showmatch                         " show matching bracket
set scrolloff=3                       " when scrolling up and down, try to keep at least 3 lines between the cursor and the edge of the screen
set number                            " turns on the line numbers
set relativenumber                    " turns on relative line numbers
set shada='100,f1                     " save marks between reloading vim
set cursorline                        " highlight line with cursor
set guicursor=                        " disable cursor management by neovim

set autowrite                         " save the file when switching to another file
set autochdir                         " sets the vim context to the dir of the current buffer

set nobackup                          " disable temporary backup files
set nowritebackup                     " disable temporary backup files
set noswapfile                        " turn off the swap file (the example.txt~ file)

set nowrap                            " turn off line wrapping
set formatoptions-=t                  " default is tcq, removing t - http://vimdoc.sourceforge.net/htmldoc/change.html#fo-table
set textwidth=160                     " maximum width of a line upon insertion
set linebreak                         " when auto inserting linebreaks, don't split words
set expandtab                         " convert any tabs entered into spaces
set tabstop=2                         " how many spaces to insert in expandtab
set softtabstop=2                     " treats certain operations on softtabs as and go back multiple spaces
set shiftwidth=2                      " how many spaces when using << or >>
set shiftround                        " causes shifts to align to a multiple of the shift width
set backspace=indent,eol,start        " Backspace behavior

set completeopt=menu,menuone,noselect " Needed for nvim-cmp autocompletion to work

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" REMAPPING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" useful shortcuts for navigating windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nmap <leader>b :bn<cr>:bd#<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FIXES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" revert neovim specific behavior
unmap Y
" fix issue with markdown errors showing in nvm-cmp documentation
hi link markdownError Normal
