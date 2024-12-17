return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    -- build = "make tiktoken",
    opts = {
      question_header = "##   User ",
      answer_header = "##   Copilot ",
      error_header = "##   Error ",
      separator = "―――――――",
      -- show_folds = false,
      -- context = "buffer",
      highlight_headers = false,
      mappings = {
        reset = {
          normal = '<C-x>',
          insert = '<C-x>',
        }
      },
      {
        window = {
          layout = 'float',
          relative = 'cursor',
          width = 1,
          height = 0.4,
          row = 1
        }
      },
      prompts = {
        CommitStaged = {
          prompt = [[
            Write commit message for the change with commitizen convention.
            MAKE SURE the title has MAXIMUM 50 characters (INCLUDING the conventional commits prefix) and message is WRAPPED at 72 characters.
            The message should only contain SUCCINT, terse bullet points starting with '-'.
            You should strive to avoid being redundant across bulletpoints.
            One feature should most times have only one bullet point.
            When writing a bullet point about neovim plugins, make sure to mention the name of the plugin.
            Wrap the whole message in code block with language gitcommit.
            Once you're done with the bullet points, DO NOT write anything else.
            Very important points to remember: be SUCCINT, make sure the title is under 50 characters, and that the bullet points are wrapped at 72 characters.
        ]],
          selection = function() return require("CopilotChat.select").gitdiff() end,
        },
      },
    },
    keys = {
      {
        "<leader>ii",
        function()
          require("CopilotChat").toggle()
        end,
        desc = "Toggle"
      },
      {
        "<leader>iu",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "Prompt actions",
      },
      {
        "<leader>io",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "Quick chat",
      }
    }
  },
}
