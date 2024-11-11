return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf");
        end
      },
      {
        "debugloop/telescope-undo.nvim",
        keys = {
          { "<leader>u", "<cmd>Telescope undo<cr>", desc = "Undo history" }
        },
        config = function()
          require("telescope").load_extension("undo");
        end
      }
      -- TODO
      -- smart open
      -- telescope ui select
    },
    keys = {
      {
        "<leader>,",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      {
        "<leader><leader>",
        mode = "n",
        function() require("telescope.builtin").find_files() end,
        desc = "find files"
      },
      -- {
      --   "<C-p>",
      --   mode = "n",
      --   function() require("telescope.builtin").git_files() end,
      --   desc = "telescope find files"
      -- },
      {
        "<leader>fg",
        mode = "n",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "grep string"
      },
      {
        "<leader>fo",
        mode = "n",
        function()
          require("telescope.builtin").oldfiles()
        end,
        desc = "old files"
      },
      {
        "<leader>fh",
        mode = "n",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "help tags"
      },
      -- {
      --   "<leader>pt",
      --   mode = "n",
      --   function()
      --     require("telescope.builtin").treesitter()
      --   end,
      --   desc = "telescope treesitter"
      -- },
    },
    opts = {
      defaults = {
        path_display = { "filename_first" },
        file_ignore_patterns = {
          "node_modules/",
          ".git/"
        },
        layout_config = {
          horizontal = {
            width = 0.97,
            height = 0.97
          }
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          find_command = { 'rg', '--files', '--color', 'never' }
        },
        oldfiles = {
          sort_lastused = true,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_moe = "smart_case"
        }
      }
    },
    config = function(_, opts)
      local colors = require("catppuccin.palettes").get_palette()
      local bgColor = "#27313F"
      local selectionColor = "#2F3A4C"

      local TelescopeColor = {
        TelescopeMatching = { fg = colors.blue },
        TelescopeSelection = { fg = colors.text, bg = selectionColor, bold = true },
        TelescopePromptTitle = { bg = selectionColor, fg = selectionColor },
        TelescopePromptBorder = { bg = selectionColor, fg = selectionColor },
        TelescopePromptPrefix = { bg = selectionColor },
        TelescopePromptNormal = { bg = selectionColor },
        TelescopePreviewTitle = { bg = bgColor, fg = bgColor },
        TelescopePreviewNormal = { bg = bgColor },
        TelescopePreviewBorder = { bg = bgColor, fg = bgColor },
        TelescopeResultsTitle = { fg = bgColor },
        TelescopeResultsBorder = { bg = bgColor, fg = bgColor },
        TelescopeResultsNormal = { bg = bgColor },
      }

      for hl, col in pairs(TelescopeColor) do
        vim.api.nvim_set_hl(0, hl, col)
      end

      require("telescope").setup(opts)
    end
  }
}
