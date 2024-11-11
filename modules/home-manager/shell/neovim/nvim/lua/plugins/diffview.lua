return
{
  "sindrets/diffview.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>dd",
      mode = "n",
      "<cmd>DiffviewFileHistory %<CR>",
      desc = "File history"
    },
    {
      "<leader>dD",
      mode = "n",
      "<cmd>DiffviewFileHistory<CR>",
      desc = "File history branch"
    }
  },
  config = true
}
