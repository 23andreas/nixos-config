return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    -- { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } }
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "anthropic",
          slash_commands = {
            ["buffer"] = {
              opts = {
                provider = "telescope",
              }
            },
            ["file"] = {
              opts = {
                provider = "telescope",
              }
            },
            -- ["help"] = {
            --   opts = {
            --     provider = "telescope",
            --   }
            -- },
            ["symbols"] = {
              opts = {
                provider = "telescope",
              }
            },
          }
        },
        inline = {
          -- adapter = "anthropic",
          adapter = "copilot",
        }
      },
      display = {
        chat = {
          render_headers = false,
        },
        action_palette = {
          provider = "telescope"
        },
      }
    })

    vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { silent = true })
    vim.keymap.set({ "n", "v" }, "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { silent = true })
    vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { silent = true })

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd([[cab cc CodeCompanion]])
  end,
}
