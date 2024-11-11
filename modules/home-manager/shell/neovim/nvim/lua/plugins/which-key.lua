return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
      require("which-key").add({
        { "<leader>b", group = "Buffer" },
        { "<leader>f", group = "Find" },
        { "<leader>l", group = "Lsp" },
        { "<leader>p", group = "Project" },
        { "<leader>t", group = "Toggle" },
        -- { "<leader>r", group = "Refactor" },
        { "<leader>x", group = "Diagnostics" },
      })
    end,
  }
}
