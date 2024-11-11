return {
  'nvim-treesitter/nvim-treesitter',
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  opts = {
    auto_install = true,
    ensure_installed = "all",
    parser_install_dir = vim.fn.stdpath("data") .. "/treesitter-parsers",
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
  }
}
