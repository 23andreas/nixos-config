return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
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
      'lazy',
      'oil',
      'trouble'
    },
  }
}

