return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    opts = {
      sync_install = false,
      parser_install_dir = vim.fn.stdpath("data") .. "/treesitter-parsers",
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      vim.treesitter.language.register('markdown', 'octo')
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
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
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = {
        lua = { 'string' }, -- it will not add pair on that treesitter node
        javascript = { 'template_string' },
        java = false,       -- don't check treesitter on java
      }
    },
    config = function(_, opts)
      require('nvim-autopairs').setup(opts)

      -- TODO fix this with blink
      -- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      -- local cmp = require('cmp')
      -- cmp.event:on(
      --   "confirm_done",
      --   cmp_autopairs.on_confirm_done()
      -- )
    end
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require('nvim-treesitter.configs').setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["ai"] = "@conditional.outer",
              ["ii"] = "@conditional.inner",
              ["a/"] = "@comment.outer",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]a"] = "@parameter.inner",
              ["]i"] = "@conditional.outer",
              ["]l"] = "@loop.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[a"] = "@parameter.inner",
              ["[i"] = "@conditional.outer",
              ["[l"] = "@loop.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>sa"] = "@parameter.inner",
              ["<leader>sf"] = "@function.outer",
            },
            swap_previous = {
              ["<leader>sA"] = "@parameter.inner",
              ["<leader>sF"] = "@function.outer",
            },
          },
        },
      })
    end
  }
}
