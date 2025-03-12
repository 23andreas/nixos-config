vim.g.mapleader = " "

-- Quit vim
vim.keymap.set({ "n", "x", "v" }, "<leader>q", ":qall<CR>", { desc = "Quit" })
vim.keymap.set({ "n", "x", "v" }, "<leader>Q", ":qall!<CR>", { desc = "Quit without saving" })

-- Paste without replacing register in visual mode
-- vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without losing register" })

-- Delete without storing in register
-- vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without register" })

-- Copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy line to system clipboard" })

-- Center search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Center when scrolling page with <C-d> and <C-u>
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Buffer
vim.keymap.set("n", "<leader>bw", ":w<CR>", { desc = "Buffer write" })
vim.keymap.set("n", "<leader>bf", function() vim.lsp.buf.format({ async = false }) end, { desc = "Buffer format" })

-- Navigate windows
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })

-- Resize windows
vim.keymap.set("n", "<C-M-h>", ":vertical resize -10<CR>", { silent = true })
vim.keymap.set("n", "<C-M-l>", ":vertical resize +10<CR>", { silent = true })
vim.keymap.set("n", "<C-M-j>", ":resize +10<CR>", { silent = true })
vim.keymap.set("n", "<C-M-k>", ":resize -10<CR>", { silent = true })

-- Create an autocommand to set keymaps for oil.nvim
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'oil',
  callback = function()
    -- Navigate windows in oil.nvim
    vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true, buffer = true })
    vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true, buffer = true })
    vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true, buffer = true })
    vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true, buffer = true })
  end
})

-- Clear search highlight ESC
vim.keymap.set("n", "<ESC>", ":noh<CR>", { silent = true })

-- Git browse
-- vim.keymap.set({ 'n', 'v' }, '<leader>ho', vim.cmd.GBrowse, { desc = "Open in github" })
-- vim.keymap.set({ 'n', 'v' }, '<leader>hO', ":GBrowse origin/master:%<CR>", { desc = "Open in github master" })

-- ESC in terminal
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
