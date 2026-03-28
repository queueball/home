--------------------------------------------------------------------------------
-- lazy.nvim bootstrap
--------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--------------------------------------------------------------------------------
-- plugin management
--------------------------------------------------------------------------------
require("lazy").setup({
  -- Utilities
  "godlygeek/tabular",
  "tpope/vim-repeat",
  "tpope/vim-surround",
  "tpope/vim-vinegar",

  -- UI / Theme
  "Mofiqul/vscode.nvim",
  "nvim-lualine/lualine.nvim",

  -- LSP / Completion
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/vim-vsnip",

  -- Mason
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  -- Utilities
  "folke/which-key.nvim",
})

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
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>']     = cmp.mapping.scroll_docs(-4),
    ['<C-f>']     = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>']     = cmp.mapping.abort(),
    ['<CR>']      = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})

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
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.keymap.set('n' , 'gD'         , vim.lsp.buf.declaration                                                 , { noremap = true, silent = true, buffer = bufnr })
  vim.keymap.set('n' , 'gd'         , vim.lsp.buf.definition                                                  , { noremap = true, silent = true, buffer = bufnr })
  vim.keymap.set('n' , 'K'          , vim.lsp.buf.hover                                                       , { noremap = true, silent = true, buffer = bufnr })
  vim.keymap.set('n' , 'gi'         , vim.lsp.buf.implementation                                              , { noremap = true, silent = true, buffer = bufnr })
  vim.keymap.set('n' , '<leader>k'  , vim.lsp.buf.signature_help                                              , { noremap = true, silent = true, buffer = bufnr })
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
vim.lsp.config("pylsp", {
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
        pycodestyle = { enabled = false },
        flake8      = { enabled = true },
      }
    }
  },
})
vim.lsp.enable("pylsp")

vim.lsp.config("lua_ls", {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})
vim.lsp.enable("lua_ls")

--------------------------------------------------------------------------------
-- vanilla setups
--------------------------------------------------------------------------------
local vanilla_setups = {
  "mason",
  "mason-lspconfig",
  "which-key",
}

for _, value in ipairs(vanilla_setups) do
  require(value).setup()
end

--------------------------------------------------------------------------------
-- direct port of .vimrc
--------------------------------------------------------------------------------
vim.cmd("source " .. vim.fn.stdpath("config") .. "/vimscript/custom.vim")

--------------------------------------------------------------------------------
-- Terminal Cursor Reset
--------------------------------------------------------------------------------
-- Resets cursor to terminal default on exit
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    os.execute("printf '\\e[0 q' > /dev/tty")
  end,
})
