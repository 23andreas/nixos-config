return
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
      function() require("neogit").open({ kind = "auto" }) end,
      desc = "Neogit"
    }
  },
  config = true
}
