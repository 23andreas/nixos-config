return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = {
      enable = true,
      max_lines = 5,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 3,
      trim_scope = 'outer',
      mode = 'cursor',
    }
  }
}
