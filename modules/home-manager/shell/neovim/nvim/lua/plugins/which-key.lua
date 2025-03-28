return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
      require("which-key").add({
        { "<leader>b", group = "Buffer" },
        { "<leader>d", group = "Diff " },
        { "<leader>o", group = "Focus" },
        { "<leader>s", group = "Treesitter" },
        { "<leader>f", group = "Find" },
        { "<leader>l", group = "Lsp" },
        { "<leader>p", group = "Project" },
        { "<leader>t", group = "Toggle" },
        -- { "<leader>r", group = "Refactor" },
        { "<leader>x", group = "Diagnostics" },
        { "<leader>i", group = "Copilot" },
        { "<leader>a", group = "AI" },
      })
    end,
  }
}
