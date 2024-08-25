vim.g.mapleader = " "

-- Paste without replacing register in visual mode
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without losing register" })

-- delete without storing in register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without register" })

-- copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy line to system clipboard" })

-- center search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- center when scrolling page with <C-d> and <C-u>
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- buffer
vim.keymap.set("n", "<leader>bw", ":w<CR>", { desc = "Buffer write" })
vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, { desc = "Buffer format" })

-- Navigate windows
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Resize windows
vim.api.nvim_set_keymap('n', '<C-M-h>', ':vertical resize -5<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-M-l>', ':vertical resize +5<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-M-j>', ':resize +5<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-M-k>', ':resize -5<CR>', { noremap = true, silent = true })

-- Clear search highligh ESC
vim.api.nvim_set_keymap('n', '<ESC>', ':noh<CR>', { noremap = true, silent = true })

-- Git browse
vim.keymap.set({ 'n', 'v' }, '<leader>ho', vim.cmd.GBrowse, { desc = "Open in github" })
vim.keymap.set({ 'n', 'v' }, '<leader>hO', ":GBrowse origin/master:%<CR>", { desc = "Open in github master" })

vim.keymap.set({ 'n', 'v' }, '<leader>hh', vim.cmd.Git, { desc = "Git" })

-- Buffer
-- Function to delete all unchanged buffers
local function delete_unchanged_buffers()
  -- Get a list of all buffers
  local buffers = vim.api.nvim_list_bufs()

  -- Iterate over each buffer
  for _, buf in ipairs(buffers) do
    -- Check if the buffer is listed and not modified
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].modifiable and not vim.bo[buf].modified then
      -- If true, delete the buffer using the 'bd' command
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end

vim.keymap.set("n", '<leader>bo', ':call DeleteUnchangedBuffers()<CR>',
  { desc = "Delete unchanged buffers", noremap = true, silent = true })
-- vim.keymap.set("n", '<leader>bo', ':1,1000bd<CR>', { desc = "Delete unchanged buffers", noremap = true, silent = true})

vim.keymap.set("n", '<leader>bk', ':bd<CR>', { desc = "Kill", noremap = true, silent = true })

-- TABS
-- Open a new tab
vim.api.nvim_set_keymap('n', '<leader>tn', ':tabnew<CR>', { noremap = true, silent = true })

-- Close the current tab
vim.api.nvim_set_keymap('n', '<leader>tc', ':tabclose<CR>', { noremap = true, silent = true })

-- Navigate to the next tab
vim.api.nvim_set_keymap('n', '<leader>tl', ':tabnext<CR>', { noremap = true, silent = true })

-- Navigate to the previous tab
vim.api.nvim_set_keymap('n', '<leader>th', ':tabprevious<CR>', { noremap = true, silent = true })

-- Navigate to the first tab
vim.api.nvim_set_keymap('n', '<leader>tf', ':tabfirst<CR>', { noremap = true, silent = true })

-- Navigate to the last tab
vim.api.nvim_set_keymap('n', '<leader>te', ':tablast<CR>', { noremap = true, silent = true })
