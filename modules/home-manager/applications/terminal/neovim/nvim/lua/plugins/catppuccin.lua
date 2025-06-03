return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      transparent_background = true,
      no_italic = true,
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
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
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
