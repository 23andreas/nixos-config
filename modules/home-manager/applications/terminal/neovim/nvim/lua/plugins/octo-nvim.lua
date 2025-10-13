return {
  'pwntester/octo.nvim',
  -- //Lazy load this?
  -- Setting priority to load octo before catppuccin because of this
  -- https://github.com/pwntester/octo.nvim/issues/1010
  priority = 900,
  cmd = "Octo",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- "ibhagwan/fzf-lua",
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    require("octo").setup({
      use_local_fs = true,
    })
  end
}
