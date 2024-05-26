vim.g.mapleader = " "

-- Paste without replacing register in visual mode
vim.keymap.set("x", "<leader>p", [["_dP]])

-- delete without storing in register
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- copy to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- center search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- center when scrolling page with <C-d> and <C-u>
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- buffer
vim.keymap.set("n", "<leader>bw", ":w<CR>", { desc = "Buffer write" })
vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, { desc = "Buffer format" })
