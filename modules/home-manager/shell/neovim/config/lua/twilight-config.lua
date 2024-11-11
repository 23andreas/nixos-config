require("twilight").setup({
  treesitter = true,
  dimming = {
    alpha = 0.5,
    term_bg = "#FFF8F5"
  }
})

-- Add keybinding to toggle Twilight
vim.keymap.set('n', '<leader>tw', ':Twilight<CR>', { noremap = true, silent = true, desc = "Toggle Twilight" })
