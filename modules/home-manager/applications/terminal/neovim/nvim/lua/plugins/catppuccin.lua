return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent_background = true,
    no_italic = true,
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    custom_highlights = function(colors)
      return {
        SnacksIndent = { fg = colors.surface0 },
        SnacksIndentScope = { fg = colors.overlay2 }
      }
    end,
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
      telescope = true,
      lsp_trouble = true,
      which_key = true,
    }
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
