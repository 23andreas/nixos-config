return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    opts = function()
      local chat = require('CopilotChat')
      local prompts = require('CopilotChat.config.prompts')

      local COPILOT_PLAN = [[
      You are a software architect and technical planner focused on clear, actionable development plans.
      ]] .. prompts.COPILOT_BASE.system_prompt .. [[

      When creating development plans:

      - Start with a high-level overview
      - Break down into concrete implementation steps
      - Identify potential challenges and their solutions
      - Consider architectural impacts
      - Note required dependencies or prerequisites
      - Estimate complexity and effort levels
      - Track confidence percentage (0-100%)
      - Format in markdown with clear sections

      Always end with:
      "Current Confidence Level: X%"
      "Would you like to proceed with implementation?" (only if confidence >= 90%)
      ]]
      return {
        model = "claude-3.7-sonnet",
        highlight_headers = false,
        mappings = {
          show_diff = {
            full_diff = true
          },
          reset = {
            normal = '<C-x>',
            insert = '<C-x>',
          }
        },
        prompts = {
          Plan = {
            prompt =
            'Create or update the development plan for the selected code. Focus on architecture, implementation steps, and potential challenges.',
            system_prompt = COPILOT_PLAN,
            context = 'file:.copilot/plan.md',
            progress = function()
              return false
            end,
            callback = function(response, source)
              chat.chat:append('Plan updated successfully!', source.winnr)
              local plan_file = source.cwd() .. '/.copilot/plan.md'
              local dir = vim.fn.fnamemodify(plan_file, ':h')
              vim.fn.mkdir(dir, 'p')
              local file = io.open(plan_file, 'w')
              if file then
                file:write(response)
                file:close()
              end
            end,
          },
        },
      }
    end,
    keys = {
      {
        "<leader>ii",
        function()
          require("CopilotChat").toggle()
        end,
        desc = "Toggle"
      },
      {
        "<leader>ii",
        function()
          require("CopilotChat").toggle()
        end,
        mode = "v",
        desc = "Toggle"
      },
      {
        "<leader>iu",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        mode = { "v", "n" },
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
        mode = { "v", "n" },
        desc = "Quick chat",
      }
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-*",
        callback = function()
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
        end,
      })
      require("CopilotChat").setup(opts)
    end,
  },
}
