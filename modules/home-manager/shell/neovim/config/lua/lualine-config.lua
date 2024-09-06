require("lualine").setup {
  options = {
    section_separators = {
      left = '',
    },
    component_separators = {
      left = '',
      right = ''
    }
  },
  sections = {
    lualine_a = {},
    lualine_b = { "branch", "diff" },
    lualine_c = {
      {
        'filename',
        path = 1,
      }
    },
    lualine_x = { "diagnostics", "filetype" },
    lualine_y = {},
    lualine_z = {}
  },
  extensions = {
    'aerial',
    'fugitive',
    'mundo',
    'oil',
  },
}
