require("nvim-treesitter.configs").setup({
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ap"] = "@parameter.outer",
        ["ip"] = "@parameter.inner",
      },
      selection_modes = {
        ['@function.outer'] = 'V',
        ['@class.outer'] = 'V',
      },
      include_surrounding_whitespace = false,
    },
    swap = {
      enable = true,
      swap_next = {
        -- ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        -- ["<leader>A"] = "@parameter.inner",
      },
    },

    move = {
      enable = true,
      set_jumps = false,

      goto_previous_start = {
        ["[p"] = "@parameter.outer",
        ["[f"] = "@function.outer",
        ["[z"] = "@fold",
      },

      goto_next_start = {
        ["]p"] = "@parameter.outer",
        ["]f"] = "@function.outer",
        ["]z"] = "@fold",
      },
    },

    lsp_interop = {
      enable = true,
      border = 'none',
      floating_preview_opts = {},
      peek_definition_code = {
        ["<leader>lf"] = "@function.outer",
        ["<leader>lF"] = "@class.outer",
      }
    },
  },
})

-- local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
--
-- -- Repeat movement with ; and ,
-- -- ensure ; goes forward and , goes backward regardless of the last direction
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- local gs = require("gitsigns")
--
-- -- make sure forward function comes first
-- local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
-- -- Or, use `make_repeatable_move` or `set_last_move` functions for more control. See the code for instructions.
--
-- vim.keymap.set({ "n", "x", "o" }, "]c", next_hunk_repeat)
-- vim.keymap.set({ "n", "x", "o" }, "[c", prev_hunk_repeat)
