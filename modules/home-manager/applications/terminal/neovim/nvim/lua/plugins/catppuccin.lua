return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  opts = {
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    transparent_background = true,
    float = {
      transparent = true,
    },
    -- dim_inactive = {
    --   enabled = true,
    --   shade = "dark",
    --   percentage = 0.15,
    -- },
    no_italic = true,
    -- custom_highlights = function(colors)
    --   return {
    --     -- SnacksIndent = { fg = colors.surface0 },
    --     -- SnacksIndentScope = { fg = colors.overlay2 }
    --   }
    -- end,
    integrations = {
      blink_cmp = true,
      diffview = true,
      gitsigns = true,
      grug_far = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = false,
      },
      neotree = true,
      neogit = true,
      nvim_surround = true,
      treesitter_context = true,
      octo = true,
      render_markdown = true,
      snacks = {
        enabled = true,
        -- indent_scope_color = "",
      },
      -- telescope = true,
      lsp_trouble = true,
      which_key = true,
    }
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
