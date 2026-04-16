--------------------------------------------------------------------------------
-- General Settings & Leader
--------------------------------------------------------------------------------
vim.g.mapleader = ","

local opt = vim.opt

-- General
opt.mouse = "a"                         -- Enable mouse in all modes
opt.mousefocus = true                  -- Move focus with mouse
opt.lazyredraw = true                   -- Helps with rendering macros
opt.showmatch = true                    -- Show matching bracket
opt.scrolloff = 3                       -- Keep 3 lines above/below cursor
opt.number = true                       -- Line numbers
opt.relativenumber = true               -- Relative line numbers
opt.shada = "'100,f1"                   -- Save marks between reloads
opt.cursorline = true                   -- Highlight current line
opt.autowrite = true                    -- Save on switch
opt.autochdir = true                    -- Change dir to current buffer
opt.laststatus = 3                      -- Global statusline (modern Neovim)
opt.clipboard = "unnamedplus"           -- yanks go to clipboard, fix for ghostty

-- Backup & Swaps
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- Text Formatting
opt.wrap = false                        -- No line wrapping
opt.formatoptions:remove("t")           -- Don't auto-wrap text
opt.textwidth = 160
opt.linebreak = true                    -- Don't split words on wrap
opt.expandtab = true                    -- Tabs to spaces
opt.tabstop = 2                         -- Tab size
opt.softtabstop = 2
opt.shiftwidth = 2                      -- Indent size
opt.shiftround = true                   -- Align to shiftwidth
opt.backspace = { "indent", "eol", "start" }

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }

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
  "echasnovski/mini.align",
  "tpope/vim-repeat",
  "tpope/vim-surround",
  "tpope/vim-vinegar",

  -- UI / Theme
  "Mofiqul/vscode.nvim",
  "nvim-lualine/lualine.nvim",

  -- LSP / Completion
  "neovim/nvim-lspconfig",
  {
    'saghen/blink.cmp',
    version = '*',
    dependencies = 'rafamadriz/friendly-snippets',
  },

  -- Mason
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  -- Utilities
  "folke/which-key.nvim",
})

--------------------------------------------------------------------------------
-- plugin setups
--------------------------------------------------------------------------------
require("vscode").setup {}
require('lualine').setup {
  options = { theme = 'vscode' },
  tabline = {
    lualine_a = { 'buffers' },
    lualine_z = { 'tabs' },
  }
}

require('blink.cmp').setup({
  keymap = { preset = 'default' },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono'
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
})

local vanilla_setups = {
  "mason",
  "mason-lspconfig",
  "which-key",
  "mini.align",
}
for _, value in ipairs(vanilla_setups) do
  require(value).setup()
end

--------------------------------------------------------------------------------
-- Keymaps
--------------------------------------------------------------------------------
local k = vim.keymap

-- Diagnostics
k.set('n', '<leader>e', vim.diagnostic.open_float)
k.set('n', '[d', vim.diagnostic.goto_prev)
k.set('n', ']d', vim.diagnostic.goto_next)
k.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Window navigation
k.set('', '<C-j>', '<C-W>j')
k.set('', '<C-k>', '<C-W>k')
k.set('', '<C-h>', '<C-W>h')
k.set('', '<C-l>', '<C-W>l')

-- Buffers
k.set('n', '<leader>b', ':bn<cr>:bd#<cr>', { silent = true })

-- Fixes
k.set('n', 'Y', 'Y') -- Revert Neovim's Y=y$ to old Vim Y=yy behavior

--------------------------------------------------------------------------------
-- LSP Config
--------------------------------------------------------------------------------
local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  k.set('n', 'gD', vim.lsp.buf.declaration, opts)
  k.set('n', 'gd', vim.lsp.buf.definition, opts)
  k.set('n', 'K', vim.lsp.buf.hover, opts)
  k.set('n', 'gi', vim.lsp.buf.implementation, opts)
  k.set('n', '<leader>k', vim.lsp.buf.signature_help, opts)
  k.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  k.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  k.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
  k.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
  k.set('n', '<leader>r', vim.lsp.buf.rename, opts)
  k.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  k.set('n', 'gr', vim.lsp.buf.references, opts)
  k.set('n', '<leader>f', vim.lsp.buf.format, opts)
end

local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config("pylsp", {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    pylsp = {
      configurationSources = { "flake8" },
      plugins = {
        jedi_completion     = { enabled = true },
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
      diagnostics = { globals = { "vim" } },
    },
  },
})
vim.lsp.enable("lua_ls")

--------------------------------------------------------------------------------
-- Highlights & Fixes
--------------------------------------------------------------------------------
vim.api.nvim_set_hl(0, "markdownError", { link = "Normal" })
