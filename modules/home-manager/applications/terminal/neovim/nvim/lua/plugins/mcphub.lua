return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = "MCPHub",
  build = "bundled_build.lua",
  config = function()
    require("mcphub").setup({
      use_bundled_binary = true,
      config = vim.fn.expand("~/.config/mcp-hub/servers.json"),
      auto_approve = false,
      extensions = {
        avante = {
          make_slash_commands = true,
        },
        codecompanion = {
          -- Show the mcp tool result in the chat buffer
          show_result_in_chat = true,
          make_vars = true,           -- make chat #variables from MCP server resources
          make_slash_commands = true, -- make /slash_commands from MCP server prompts
        },
      }
    })
  end,
}
