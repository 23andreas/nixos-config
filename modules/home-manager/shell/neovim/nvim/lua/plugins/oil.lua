return {
  {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      }
    },
    keys = {
      {
        "<leader>R",
        function() require("oil").open() end,
        desc = "Oil"
      }
    }
  }
}
