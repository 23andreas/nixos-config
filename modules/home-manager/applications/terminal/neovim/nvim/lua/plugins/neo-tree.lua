return
{
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  keys = {
    {
      "<leader>E",
      "<cmd>Neotree toggle<CR>",
      desc = "NeoTree"
    },
    {
      "<leader>R",
      "<cmd>Neotree position=current reveal<CR>",
      desc = "NeoTree"
    }
  }
}
