return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  build = "bundled_build.lua",
  config = function()
    require("mcphub").setup({
      use_bundled_binary = true,
      config = vim.fn.expand("~/.config/mcp-hub/servers.json"),
      auto_approve = false,
      -- global_env = function(context)
      --   return {
      --     REPOSITORY_PATH = vim.fn.getcwd(),
      --   }
      -- end,
      global_env = function(context)
        local cwd = vim.fn.getcwd()
        print("[mcphub.nvim] REPOSITORY_PATH is set to: " .. cwd)
        return {
          REPOSITORY_PATH = cwd,
        }
      end,
      extensions = {
        copilotchat = {
          enabled = true,
          convert_tools_to_functions = true,     -- Convert MCP tools to @functions
          convert_resources_to_functions = true, -- Convert MCP resources to @functions
          add_mcp_prefix = false,                -- Add "mcp_" prefix to function names
        },
        -- avante = {
        --   make_slash_commands = true,
        -- },
        -- codecompanion = {
        --   -- Show the mcp tool result in the chat buffer
        --   show_result_in_chat = true,
        --   make_vars = true,           -- make chat #variables from MCP server resources
        --   make_slash_commands = true, -- make /slash_commands from MCP server prompts
        -- },
      }
    })
  end,
}
