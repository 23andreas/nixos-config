local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

require("lazy").setup("plugins", {
  rocks = { enabled = false },
  dev = {
    path = "~/.local/share/nvim/nix",
    fallback = false,
  }
})

vim.lsp.enable({
  "eslint",
  "json",
  "lua",
  "nixd",
  "rust",
  -- "copilot",
})

-- Enable default LSP keymaps
vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { desc = 'vim.lsp.buf.rename()' })
vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, { desc = 'vim.lsp.buf.code_action()' })
vim.keymap.set('n', 'grr', vim.lsp.buf.references, { desc = 'vim.lsp.buf.references()' })
vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, { desc = 'vim.lsp.buf.signature_help()' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'vim.lsp.buf.definition()' })

require("config")
