require("diffview").setup()

vim.api.nvim_set_keymap("n", "<leader>dh", "<cmd>DiffviewFileHistory %<CR>",
  { noremap = true, silent = true, desc = "Diffview: File history" })

vim.api.nvim_set_keymap("n", "<leader>dH", "<cmd>DiffviewFileHistory<CR>",
  { noremap = true, silent = true, desc = "Diffview: File history branch" })

vim.api.nvim_set_keymap("n", "<leader>dc", "<cmd>DiffviewClose<CR>",
  { noremap = true, silent = true, desc = "Diffview: Close" })

vim.api.nvim_set_keymap("n", "<leader>df", "<cmd>DiffviewToggleFiles<CR>",
  { noremap = true, silent = true, desc = "Diffview: Toggle Files" })
