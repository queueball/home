--------------------------------------------------------------------------------
-- on initial setup, handle adding the package manager
--------------------------------------------------------------------------------
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[ packadd packer.nvim ]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

--------------------------------------------------------------------------------
-- status bar
--------------------------------------------------------------------------------
require("vscode").setup {}  -- theme
require('lualine').setup {
  options = { theme = 'vscode' },
  tabline = {
    lualine_a = { 'buffers' },
    lualine_z = { 'tabs' },
  }
}
--------------------------------------------------------------------------------
-- diagnostic helpers
--------------------------------------------------------------------------------
vim.keymap.set('n' , '<leader>e' , vim.diagnostic.open_float , { noremap = true, silent = true })
vim.keymap.set('n' , '[d'        , vim.diagnostic.goto_prev  , { noremap = true, silent = true })
vim.keymap.set('n' , ']d'        , vim.diagnostic.goto_next  , { noremap = true, silent = true })
vim.keymap.set('n' , '<leader>q' , vim.diagnostic.setloclist , { noremap = true, silent = true })


--------------------------------------------------------------------------------
-- Set up nvim-cmp
--------------------------------------------------------------------------------
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args) -- REQUIRED - you must specify a snippet engine
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>']     = cmp.mapping.scroll_docs(-4),
    ['<C-f>']     = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>']     = cmp.mapping.abort(),
    ['<CR>']      = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (incompatible with `native_menu`).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

--------------------------------------------------------------------------------
-- nvim-lspconfig
--------------------------------------------------------------------------------

local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc') -- Enable completion triggered by <c-x><c-o>

  vim.keymap.set('n' , 'gD'         , vim.lsp.buf.declaration                                                 , { noremap = true, silent = true, buffer = bufnr })
  vim.keymap.set('n' , 'gd'         , vim.lsp.buf.definition                                                  , { noremap = true, silent = true, buffer = bufnr })
  vim.keymap.set('n' , 'K'          , vim.lsp.buf.hover                                                       , { noremap = true, silent = true, buffer = bufnr })
  vim.keymap.set('n' , 'gi'         , vim.lsp.buf.implementation                                              , { noremap = true, silent = true, buffer = bufnr })
  vim.keymap.set('n' , '<C-k>'      , vim.lsp.buf.signature_help                                              , { noremap = true, silent = true, buffer = bufnr })
  vim.keymap.set('n' , '<leader>wa' , vim.lsp.buf.add_workspace_folder                                        , { noremap = true, silent = true, buffer = bufnr })
  vim.keymap.set('n' , '<leader>wr' , vim.lsp.buf.remove_workspace_folder                                     , { noremap = true, silent = true, buffer = bufnr })
  vim.keymap.set('n' , '<leader>wl' , function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end , { noremap = true, silent = true, buffer = bufnr })
  vim.keymap.set('n' , '<leader>D'  , vim.lsp.buf.type_definition                                             , { noremap = true, silent = true, buffer = bufnr })
  vim.keymap.set('n' , '<leader>r'  , vim.lsp.buf.rename                                                      , { noremap = true, silent = true, buffer = bufnr })
  vim.keymap.set('n' , '<leader>ca' , vim.lsp.buf.code_action                                                 , { noremap = true, silent = true, buffer = bufnr })
  vim.keymap.set('n' , 'gr'         , vim.lsp.buf.references                                                  , { noremap = true, silent = true, buffer = bufnr })
  vim.keymap.set('n' , '<leader>f'  , vim.lsp.buf.format                                                      , { noremap = true, silent = true, buffer = bufnr })
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

--------------------------------------------------------------------------------
-- Start the lsp
--------------------------------------------------------------------------------
local lspconfig = require('lspconfig')

lspconfig.pylsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    pylsp = {
      configurationSources = { "flake8" },
      plugins = {
        jedi_completion     = { enabled = true },
        jedi_hover          = { enabled = true },
        jedi_references     = { enabled = true },
        jedi_signature_help = { enabled = true },
        jedi_symbols        = { enabled = true, all_scopes = true },
        pycodestyle = { enabled = true },
        flake8      = { enabled = true },
      }
    }
  },
}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}

--------------------------------------------------------------------------------
-- vanilla setups
--------------------------------------------------------------------------------
local vanilla_setups = {
  "mason",           -- LSP management
  "mason-lspconfig", -- LSP management
  "which-key",       -- utilities
}

for _, value in pairs(vanilla_setups) do
  require(value).setup()
end

--------------------------------------------------------------------------------
-- direct port of .vimrc
--------------------------------------------------------------------------------
vim.cmd [[ source ~/.config/nvim/vimscript/custom.vim ]]

--------------------------------------------------------------------------------
-- manage the plugins
--------------------------------------------------------------------------------
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'https://github.com/godlygeek/tabular.git'

  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-vinegar' -- simpler navigation

  use 'Mofiqul/vscode.nvim'
  use 'nvim-lualine/lualine.nvim'

  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp' -- autocompletion, no func signatures
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"

  use "folke/which-key.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
