-- require('render-markdown').setup()
local codeCompanion = require('codecompanion')

codeCompanion.setup({
  -- opts = {
  --   log_level = "DEBUG",
  -- },
  display = {
    -- action_palette = {
    --   provider = "telescope"
    -- },
    chat = {
      -- slash_commands = {
      --   ["buffer"] = {
      --     opts = {
      --       provider = "telescope"
      --     }
      --   }
      -- },
      render_headers = false,
      window = {
        layout = "vertical",
      },
      show_settings = true
    }
  }
})

vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { silent = true })
vim.keymap.set({ "n", "v" }, "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

