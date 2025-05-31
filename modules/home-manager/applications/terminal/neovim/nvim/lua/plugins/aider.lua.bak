return {
  "GeorgesAlkhouri/nvim-aider",
  priority = 1100,
  lazy = true,
  event = { "VeryLazy" },
  cmd = {
    "AiderTerminalToggle", "AiderHealth",
  },
  keys = {
    { "<leader>a/", "<cmd>AiderTerminalToggle<cr>",    desc = "Open Aider" },
    { "<leader>as", "<cmd>AiderTerminalSend<cr>",      desc = "Send to Aider",                  mode = { "n", "v" } },
    { "<leader>ac", "<cmd>AiderQuickSendCommand<cr>",  desc = "Send Command To Aider" },
    { "<leader>ab", "<cmd>AiderQuickSendBuffer<cr>",   desc = "Send Buffer To Aider" },
    { "<leader>a+", "<cmd>AiderQuickAddFile<cr>",      desc = "Add File to Aider" },
    { "<leader>a-", "<cmd>AiderQuickDropFile<cr>",     desc = "Drop File from Aider" },
    { "<leader>ar", "<cmd>AiderQuickReadOnlyFile<cr>", desc = "Add File as Read-Only" },
    -- nvim-tree.lua integration
    { "<leader>at+", "<cmd>AiderTreeAddFile<cr>",      desc = "Add File from Tree to Aider",    ft = "NvimTree" },
    { "<leader>at-", "<cmd>AiderTreeDropFile<cr>",     desc = "Drop File from Tree from Aider", ft = "NvimTree" },
  },
  dependencies = {
    "folke/snacks.nvim",
    --- The below dependencies are optional
    "catppuccin/nvim",
    "nvim-tree/nvim-tree.lua",
    --- Neo-tree integration
    -- {
    --   "nvim-neo-tree/neo-tree.nvim",
    --   opts = function(_, opts)
    --     -- Example mapping configuration (already set by default)
    --     -- opts.window = {
    --     --   mappings = {
    --     --     ["+"] = { "nvim_aider_add", desc = "add to aider" },
    --     --     ["-"] = { "nvim_aider_drop", desc = "drop from aider" }
    --     --   }
    --     -- }
    --     require("nvim_aider.neo_tree").setup(opts)
    --   end,
    -- },
  },
  opts = {
    theme = {
      user_input_color = "#a6da95",
      tool_output_color = "#8aadf4",
      tool_error_color = "#ed8796",
      tool_warning_color = "#eed49f",
      assistant_output_color = "#c6a0f6",
      completion_menu_color = "#cad3f5",
      completion_menu_bg_color = "#24273a",
      completion_menu_current_color = "#181926",
      completion_menu_current_bg_color = "#f4dbd6",
    },
    args = {
      "--no-auto-commits",
      "--pretty",
      "--stream",
      "--code-theme material"
    },
    win = {
      position = "right"
    }
  },
  config = true,
}
