local focus = require("focus")

focus.setup({
  autoresize = {
    -- enable = false,
    minwidth = 25,
    minheight = 10
  },
  ui = {
    signcolumn = false,
    cursorline = false
  }
})

-- Disable plugin by default
vim.cmd('FocusToggle')

vim.keymap.set('n', '<leader>tt', ':FocusToggle<CR>', { noremap = true, silent = true, desc = "Toggle focus" })
vim.keymap.set('n', '<leader>om', ':FocusMaximise<CR>', { noremap = true, silent = true, desc = "Maximize window" })
vim.keymap.set('n', '<leader>oe', ':FocusEqualise<CR>', { noremap = true, silent = true, desc = "Equalize windows" })

local ignore_filetypes = { 'Avante', 'AvanteInput' }
local ignore_buftypes = { 'nofile', 'prompt', 'popup' }
local augroup = vim.api.nvim_create_augroup('FocusDisable', { clear = true })

vim.api.nvim_create_autocmd('WinEnter', {
  group = augroup,
  callback = function(_)
    if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
      vim.w.focus_disable = true
    else
      vim.w.focus_disable = false
    end
  end,
  desc = 'Disable focus autoresize for BufType',
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  callback = function(_)
    if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
      vim.b.focus_disable = true
    else
      vim.b.focus_disable = false
    end
  end,
  desc = 'Disable focus autoresize for FileType',
})
