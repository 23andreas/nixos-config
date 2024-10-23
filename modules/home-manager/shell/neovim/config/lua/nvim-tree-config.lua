require("nvim-tree").setup({
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  respect_buf_cwd = true,
  actions = {
    open_file = {
      quit_on_open = true,
    }
  },
  view = {
    adaptive_size = true,
  }
})

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Open nvim-tree" })
