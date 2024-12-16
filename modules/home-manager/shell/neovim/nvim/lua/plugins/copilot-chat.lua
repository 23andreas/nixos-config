return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      highlight_headers = false,
      separator = "---",
      error_header = '> [!ERROR] Error',
    },
      separator = '---',
      error_header = '> [!ERROR] Error',
      {
        window = {
          layout = 'float',
          relative = 'cursor',
          width = 1,
          height = 0.4,
          row = 1
        }
      }
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
