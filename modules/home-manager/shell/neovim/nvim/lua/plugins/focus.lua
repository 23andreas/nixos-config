return {
  'nvim-focus/focus.nvim',
  version = false,
  -- cmd = "FocusToggle",
  -- lazy = true,
  -- event = "VeryLazy",
  opts = {
    autoresize = {
      minwidth = 25,
      minheight = 10,
    },
    ui = {
      signcolumn = false,
      cursorline = false
    }
  },
  keys = {
    {
      "<leader>tt",
      mode = "n",
      "<cmd>FocusToggle<CR>",
      desc = "Toggle Focus"
    },
    {
      "<leader>om",
      mode = "n",
      "<cmd>FocusMaximise<CR>",
      desc = "Focus maximise"
    },
    {
      "<leader>oe",
      mode = "n",
      "<cmd>FocusEqualise<CR>",
      desc = "Focus equalise"
    },
  },
  config = function(_, opts)
    require("focus").setup(opts)
    -- Disable by default
    vim.cmd('FocusToggle')
  end,
}
