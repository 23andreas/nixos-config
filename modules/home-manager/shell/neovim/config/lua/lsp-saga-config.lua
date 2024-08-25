require('lspsaga').setup({
  code_action_lightbulb = {
    enable = false
  },
  breadcrumb = {
    enable = false
  }
})

-- Callhierarchy
vim.keymap.set("n", "<leader>li", ':Lspsaga incoming_calls<CR>', { desc = "Incoming calls", noremap = true })
vim.keymap.set("n", "<leader>lo", ':Lspsaga outgoing_calls<CR>', { desc = "Incoming calls", noremap = true })

-- Code actions
vim.keymap.set("n", "<leader>la", ':Lspsaga code_action<CR>', { desc = "Code actions", noremap = true })

-- Peek definition
vim.keymap.set("n", "<leader>ll", ':Lspsaga peek_definition<CR>', { desc = "Definition", noremap = true })
vim.keymap.set("n", "<leader>lt", ':Lspsaga peek_type_definition<CR>', { desc = "Type definition", noremap = true })

-- Diagnostic jump
vim.keymap.set("n", "<leader>ld", ':Lspsaga diagnostic_jump_next<CR>', { desc = "Diagnostic jump next", noremap = true })
vim.keymap.set("n", "<leader>lu", ':Lspsaga diagnostic_jump_prev<CR>', { desc = "Diagnostic jump previous", noremap = true })
