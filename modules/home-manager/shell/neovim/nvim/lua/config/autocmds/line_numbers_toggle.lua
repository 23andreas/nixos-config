local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- LINE NUMBER SETTINGS
vim.wo.number = true
local numbertoggle_group = augroup('numbertoggle', { clear = true })

autocmd(
  { 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
    pattern = '*',
    callback = function()
      if vim.wo.number and vim.api.nvim_get_mode().mode ~= 'i' then
        vim.wo.relativenumber = true
      end
    end,
    group = numbertoggle_group
  }
)

autocmd(
  { 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
    pattern = '*',
    callback = function()
      if vim.wo.number then
        vim.wo.relativenumber = false
      end
    end,
    group = numbertoggle_group
  }
)
