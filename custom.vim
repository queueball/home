let mapleader = ','

filetype plugin indent on       " turns on filetype detection, load <filetype>plugin.vim, <filetype>indent.vim

" colorscheme koehler
" syntax enable                 " syntax coloring

set mouse=a                     " Enable the use of mouse in all modes, need for terminal version
set mousefocus                  " move focus with mouse
" set ttyfast                   " hints at a fast terminal connection
set lazyredraw                  " helps with rendering when running macros
" set wildmenu                  " command completion
" set wildmode=longest:full,full" command completion settings
" set showcmd                   " show the command you're typing in the bottom right corner
set showmatch                   " show matching bracket
set scrolloff=3                 " when scrolling up and down, try to keep at least 3 lines between the cursor and the edge of the screen
" set ruler                     " turns on cursor coordinates in the file
set number                      " turns on the line numbers
set relativenumber              " turns on relative line numbers
set shada='100,f1               " save marks between reloading vim
set cursorline                  " highlight line with cursor
set guicursor=                  " disable cursor management by neovim

" set autoread                  " reload the file under certain conditions of the file changing, like buffer updates and external commands
set autowrite                   " save the file when switching to another file
set autochdir                   " sets the vim context to the dir of the current buffer

" set incsearch                 " highlight the next word as you're searching for it
" set hlsearch                  " highlight all matching search patterns

set nobackup                    " disable temporary backup files
set nowritebackup               " disable temporary backup files
set noswapfile                  " turn off the swap file (the example.txt~ file)

set nowrap                      " turn off line wrapping
set formatoptions-=t            " default is tcq, removing t - http://vimdoc.sourceforge.net/htmldoc/change.html#fo-table
" set formatoptions+=j          " default is tcq, adding j - http://vimdoc.sourceforge.net/htmldoc/change.html#fo-table
set textwidth=160               " maximum width of a line upon insertion
set linebreak                   " when auto inserting linebreaks, don't split words
set expandtab                   " convert any tabs entered into spaces
" set autoindent                " causes new lines enter to keep the same indentation as the previous line
set tabstop=2                   " how many spaces to insert in expandtab
set softtabstop=2               " treats certain operations on softtabs as and go back multiple spaces
set shiftwidth=2                " how many spaces when using << or >>
set shiftround                  " causes shifts to align to a multiple of the shift width
set backspace=indent,eol,start  " Backspace behavior

set foldenable                  " turn on folding
set foldcolumn=1                " column width to indicate folds
set foldlevelstart=10           " by default open most folds
set foldmethod=indent
" shortcut for toggling folds
nnoremap <space> za

" useful shortcuts for navigating windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

unmap Y

nmap <leader>b :bn<cr>:bd#<cr>

" Needed for autocompletion
set completeopt=menu,menuone,noselect
" fix issues markdown errors showing in nvm-cmp documentation
hi link markdownError Normal
