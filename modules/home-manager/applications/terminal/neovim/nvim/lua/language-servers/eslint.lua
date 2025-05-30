-- local lspconfig = require("lspconfig")
--
-- return function(on_attach)
--   lspconfig.eslint.setup {
--     on_attach = function(client, bufnr)
--       client.server_capabilities.documentFormattingProvider = true
--       -- vim.api.nvim_create_autocmd("BufWritePre", {
--       --   buffer = bufnr,
--       --   command = "EslintFixAll",
--       -- })
--       on_attach(client, bufnr)
--     end,
--     settings = {
--       -- packageManager = "npm",
--       format = { enable = true },
--       workingDirectory = {
--         mode = 'auto',
--       }
--     },
--     -- root_dir = lspconfig.util.root_pattern(".eslintrc", ".eslintrc.js", "package.json"),
--   }
-- end

return {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true
    -- vim.api.nvim_create_autocmd("BufWritePre", {
    --   buffer = bufnr,
    --   command = "EslintFixAll",
    -- })
  end,
  settings = {
    -- packageManager = "npm",
    format = { enable = true },
    workingDirectory = {
      mode = 'auto',
    }
  },
}
