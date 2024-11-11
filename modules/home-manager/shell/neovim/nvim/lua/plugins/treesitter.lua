return {
  'nvim-treesitter/nvim-treesitter',
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  -- main = "nvim-treesitter.configs",
  -- dev = true,
  opts = {
    auto_install = true,
    ensure_installed = "all",
    parser_install_dir = vim.fn.stdpath("data") .. "/treesitter-parsers",
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    -- autotag = {
    --   enable = true
    -- },
    -- incremental_selection = {
    --   enable = true,
    --   -- keymaps = {
    --   --   -- init_selection = "<C-space>",
    --   --   -- node_incremental = "<C-space>",
    --   --   scope_incremental = false,
    --   --   node_decremental = "<bs>",
    --   -- },
    -- },
    textobjects = {
      move = {
        enable = true,
        goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
        goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
        goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
      },
    }
  }
}
