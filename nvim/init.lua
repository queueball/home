--------------------------------------------------------------------------------
-- on initial setup, handle adding the package manager
--------------------------------------------------------------------------------
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
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
require('lualine').setup{
  options = {
    themes = 'horizon',
  },
}


--------------------------------------------------------------------------------
-- direct port of .vimrc
--------------------------------------------------------------------------------
vim.cmd [[ source ~/.config/nvim/vimscript/custom.vim ]]

--------------------------------------------------------------------------------
-- nvim-lspconfig
--------------------------------------------------------------------------------
local opts = { noremap = true, silent = true }  -- `:help vim.diagnostic.*`
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc') -- Enable completion triggered by <c-x><c-o>

  local bufopts = { noremap = true, silent = true, buffer = bufnr }  -- `:help vim.lsp.*`
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, bufopts)
end

local lsp_flags = {
  debounce_text_changes = 150,  -- This is the default in Nvim 0.7+
}

--------------------------------------------------------------------------------
-- Set up nvim-cmp.
--------------------------------------------------------------------------------
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args) -- REQUIRED - you must specify a snippet engine
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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

-- Use cmdline & path source for ':' (incompatible with `native_menu`).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

--------------------------------------------------------------------------------
-- Start the lsp
--------------------------------------------------------------------------------
local lspconfig = require('lspconfig')
lspconfig.pylsp.setup{
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  settings = {
    pylsp = {
      configurationSources = { "flake8" },
      plugins = {
            jedi_completion = { enabled = true },
            jedi_hover = { enabled = true },
            jedi_references = { enabled = true },
            jedi_signature_help = { enabled = true },
            jedi_symbols = { enabled = true, all_scopes = true },
            pycodestyle = { enabled = true },
            flake8 = { enabled = true },
            -- mypy = { enabled = true, live_mode = true, disallow_untyped_calls = false },
            -- isort = { enabled = true },
            -- yapf = { enabled = false },
            -- pylint = { enabled = false },
            -- pydocstyle = { enabled = false },
            -- mccabe = { enabled = false },
            -- preload = { enabled = false },
            -- pyflakes = { enabled = false },
            -- rope_completion = { enabled = false }
      }
    }
  },
}

lspconfig.sumneko_lua.setup{
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}

lspconfig.dockerls.setup{
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}

lspconfig.bashls.setup{
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}

--------------------------------------------------------------------------------
-- mason package manager
--------------------------------------------------------------------------------
require("mason").setup()

--------------------------------------------------------------------------------
-- manage the plugins
--------------------------------------------------------------------------------
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- PackerInstall (may require restarting nvim)
  use 'https://github.com/godlygeek/tabular.git'

  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-vinegar' -- simpler navigation

  use 'nvim-lualine/lualine.nvim'

  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'  -- autocompletion, no func signatures
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  use "williamboman/mason.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
