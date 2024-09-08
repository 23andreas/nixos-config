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
        path = 4,
      }
    },
    lualine_x = { "searchcount", "diagnostics" },
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
