-- local lspconfig = require("lspconfig")
--
-- return function(on_attach)
--   lspconfig.lua_ls.setup {
--     on_attach = on_attach,
--     settings = {
--       Lua = {
--         runtime = {
--           version = "LuaJIT",
--           path = vim.split(package.path, ";"),
--         },
--         diagnostics = {
--           globals = { "vim" },
--         },
--         workspace = {
--           library = vim.api.nvim_get_runtime_file("", true),
--           checkThirdParty = false,
--         },
--         telemetry = { enable = false },
--       },
--     },
--   }
-- end
--
return {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  }
}
