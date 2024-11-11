return {
  "folke/twilight.nvim",
  opts = {
    treesitter = true,
    context = 10,
    dimming = {
      alpha = 0.25,
      -- color = {
      --   "Normal", "#ffffff"
      -- }
      -- term_bg = "#1F2733"
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
