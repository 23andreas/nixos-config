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

require("lazy").setup("plugins", {
  rocks = { enabled = false },
  dev = {
    path = "~/.local/share/nvim/nix",
    fallback = false,
  }
})


-- require("nvim-treesitter.configs").setup({
--   auto_install = false, -- Parsers are managed by Nix
--   indent = {
--     enable = true,
--     disable = { "python", "yaml" }, -- Yaml and Python indents are unusable
--   },
--   highlight = {
--     enable = true,
--     disable = { "yaml" }, -- Disable yaml highlighting because Helm sucks :<
--     additional_vim_regex_highlighting = false,
--   },
-- })

-- require("nvim-treesitter.configs").setup({
--   auto_install = false,
--   indent = {
--     enable = true,
--   },
--   highlight = {
--     enable = true,
--     additional_vim_regex_highlighting = false,
--   }
-- })

require("config")
