return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    event = "VeryLazy",
    opts = {
      telescope_sorter = function()
        return require("telescope").extensions.fzf.native_fzf_sorter()
      end
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
