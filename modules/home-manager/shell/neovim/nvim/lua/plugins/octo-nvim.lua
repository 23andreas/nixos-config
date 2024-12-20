return {
  'pwntester/octo.nvim',
  -- //Lazy load this?
  dependencies = {
    "nvim-lua/plenary.nvim",
    "ibhagwan/fzf-lua",
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    require "octo".setup()
  end
}
