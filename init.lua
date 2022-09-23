local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline_powerline_fonts'] = 1
vim.g['airline#extensions#tabline#fnamemod'] = ':t'

vim.cmd([[
let mapleader = ','

filetype plugin indent on       " turns on filetype detection, load <filetype>plugin.vim, <filetype>indent.vim

" colorscheme koehler
" syntax enable                   " syntax coloring

set mouse=a                     " Enable the use of mouse in all modes, need for terminal version
set mousefocus                  " move focus with mouse
" set ttyfast                     " hints at a fast terminal connection
set lazyredraw                  " helps with rendering when running macros
" set wildmenu                    " command completion
set wildmode=longest:full,full  " command completion settings
" set showcmd                     " show the command you're typing in the bottom right corner
set showmatch                   " show matching bracket
set scrolloff=3                 " when scrolling up and down, try to keep at least 3 lines between the cursor and the edge of the screen
" set ruler                       " turns on cursor coordinates in the file
set number                      " turns on the line numbers
set relativenumber              " turns on relative line numbers
set shada='100,f1             	" save marks between reloading vim
set cursorline                  " highlight line with cursor
set guicursor=                  " disable cursot management by neovim

" set autoread                    " reload the file under certain conditions of the file changing, like buffer updates and external commands
set autowrite                   " save the file when switching to another file
set autochdir                   " sets the vim context to the dir of the current buffer

" set incsearch                   " highlight the next word as you're searching for it
" set hlsearch                    " highlight all matching search patterns

set nobackup                    " disable temporary backup files
set nowritebackup               " disable temporary backup files
set noswapfile                  " turn off the swap file (the example.txt~ file)

set nowrap                      " turn off line wrapping
set formatoptions-=t            " default is tcq, removing t - http://vimdoc.sourceforge.net/htmldoc/change.html#fo-table
" set formatoptions+=j            " default is tcq, adding j - http://vimdoc.sourceforge.net/htmldoc/change.html#fo-table
set textwidth=160               " maximum width of a line upon insertion
set linebreak                   " when auto inserting linebreaks, don't split words
set expandtab                   " convert any tabs entered into spaces
" set autoindent                  " causes new lines enter to keep the same indentation as the previous line
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

augroup vimrc
  autocmd!
augroup END

" Override tabs spacing settings for python files and run flake8 on save
autocmd vimrc Filetype python setlocal ts=4 sts=4 sw=4 makeprg=flake8
autocmd vimrc BufWritePost *.py silent make! <afile> | silent redraw!
autocmd vimrc QuickFixCmdPost [^l]* cwindow

" useful shortcuts for navigating windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

unmap Y

nmap <leader>b :bn<cr>:bd#<cr>
]])

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', ',e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', ',q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', ',wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', ',wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', ',wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', ',D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', ',rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', ',ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', ',f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require('lspconfig')['pylsp'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'https://github.com/godlygeek/tabular.git'
  use 'tpope/vim-surround'
  use 'tpope/vim-vinegar'
  use 'tpope/vim-repeat'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'neovim/nvim-lspconfig'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
