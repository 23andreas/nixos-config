return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
    },
    event = "VeryLazy",
    opts = {
      disable_hint = true,
      disable_signs = true,
      filewatcher = {
        enabled = false,
      },
      graph_style = "kitty",
      integrations = {
        diffview = true,
        snacks = true
      },
      commit_popup = {
        kind = "split",
        keymaps = {
          quit = "q",
          commit = "<C-s>",
          focus_message = "<C-m>",
          refresh = "<C-r>",
          push = "<C-p>"
        }
      },
      signs = {
        section = { "", "" }, -- Customizes signs for opened/closed sections
        item = { "", "" }, -- Customizes signs for opened/closed items
        -- hunk = { "", "" }, -- Customizes signs for hunks
      },
    },
    keys = {
      {
        "<leader>hh",
        mode = { "n", "v" },
        function()
          local neogit = require('neogit')
          if vim.fn.bufwinnr('NeogitStatus') ~= -1 then
            neogit.close()
          else
            neogit.open({ kind = "auto" })
          end
        end,
        desc = "Neogit"
      }
    },
    config = true
  }
}
