require("lualine").setup {
  options = {
    theme = "vscode"
  },
  sections = {
    lualine_b = {"branch", "diff"},
    lualine_c = {
      {
        'filename',
        path = 1,
      }
    },
    lualine_x = {"diagnostics", "filetype"},
    lualine_y = {},
    lualine_z = {}
  }
}
