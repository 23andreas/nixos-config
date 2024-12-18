return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    files = {
      formatter = "path.filename_first",
      -- git_icons = true,
      -- prompt = "files:",
      -- preview_opts = "hidden",
      no_header = true,
      cwd_header = false,
      cwd_prompt = false,
      actions = {
        ["ctrl-d"] = function(...)
          local fzf = require("fzf-lua")
          fzf.actions.file_vsplit(...)
          vim.cmd("windo diffthis")
          local switch = vim.api.nvim_replace_termcodes("<C-w>h", true, false, true)
          vim.api.nvim_feedkeys(switch, "t", false)
        end,
      },
    },
  },
  -- config = function()
  --   -- calling `setup` is optional for customization
  --   require("fzf-lua").setup({})
  -- end,

  keys = function()
    return {
      {
        "<leader><leader>",
        function()
          require('fzf-lua').files()
        end,
        desc = "Find files"
      }
    }
  end
}
