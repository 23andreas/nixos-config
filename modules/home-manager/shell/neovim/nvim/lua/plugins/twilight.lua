return {
  "folke/twilight.nvim",
  opts = {
    treesitter = true,
    dimming = {
      alpha = 0.2,
      term_bg = "#FFF8F5"
    }
  },
  keys = {
    {
      "<leader>tw",
      mode = "n",
      "<cmd>Twilight<CR>",
      desc = "Toggle Twilight"
    },
  },
  config = true
}
