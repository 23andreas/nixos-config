-- Load and configure mini.files
local miniFiles = require('mini.files')

miniFiles.setup({
  windows = {
    preview = true, -- Show file preview window
  },
  mappings = {
    -- go_in_plus = '<CR>', -- Enter directory
    -- go_in = '<Tab>',     -- Open file or folder
    -- go_out = '-',        -- Go up one directory
    -- reset = '<Esc>',     -- Reset to the root directory
  },
})

-- Keybinding to open mini.files with <leader>e
-- vim.keymap.set('n', '<leader>e', mini_files.open, { desc = 'Open files' })

vim.keymap.set("n", "<leader>e", function()
  miniFiles.open(vim.api.nvim_buf_get_name(0), false)
  miniFiles.reveal_cwd()
end, { desc = 'Open file explorer' })
