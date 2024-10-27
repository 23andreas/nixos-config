-- Load and configure mini.files
local mini_files = require('mini.files')

mini_files.setup({
  windows = {
    preview = true, -- Show file preview window
  },
  mappings = {
    go_in_plus = '<CR>', -- Enter directory
    go_in = '<Tab>',     -- Open file or folder
    go_out = '-',        -- Go up one directory
    reset = '<Esc>',     -- Reset to the root directory
  },
})

-- Keybinding to open mini.files with <leader>e
vim.keymap.set('n', '<leader>e', mini_files.open, { desc = 'Open files' })
