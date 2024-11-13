return {
  {
    "DNLHC/glance.nvim",
    cmd = 'Glance',
    keys = {
      { 'gpd', '<cmd>Glance definitions<CR>' },
      { 'gpr', '<cmd>Glance references<CR>' },
      { 'gpt', '<cmd>Glance type_definitions<CR>' },
      { 'gpi', '<cmd>Glance implementations<CR>' },
    },
    opts = function()
      local actions = require('glance').actions
      return {
        folds = {
          fold_closed = '󰅂', -- 󰅂 
          fold_open = '󰅀', -- 󰅀 
          folded = true,
        },
        mappings = {
          list = {
            ['<C-u>'] = actions.preview_scroll_win(5),
            ['<C-d>'] = actions.preview_scroll_win(-5),
            ['sg'] = actions.jump_vsplit,
            ['sv'] = actions.jump_split,
            ['st'] = actions.jump_tab,
            ['p'] = actions.enter_win('preview'),
          },
          preview = {
            ['q'] = actions.close,
            ['p'] = actions.enter_win('list'),
          },
        },
      }
    end,
    config = function(_, opts)
      local bgColor = "#27313f"
      local matchColor = "#2F3B4C"
      local borderColor = "#171D26"

      vim.api.nvim_set_hl(0, "GlanceBorderTop", { bg = borderColor })
      vim.api.nvim_set_hl(0, "GlancePreviewNormal", { bg = bgColor })
      vim.api.nvim_set_hl(0, "GlancePreviewMatch", { bg = matchColor })

      vim.api.nvim_set_hl(0, "GlanceListNormal", { bg = bgColor })

      require("glance").setup(opts)
    end
  }
}
