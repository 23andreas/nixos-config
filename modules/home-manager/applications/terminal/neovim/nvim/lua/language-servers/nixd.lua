-- local lspconfig = require("lspconfig")
--
-- return function(on_attach)
--   lspconfig.nixd.setup {
--     on_attach = function(client, bufnr)
--       on_attach(client, bufnr)
--     end,
--     settings = {
--       nixd = {
--         formatting = {
--           command = "nixfmt --no-expand-braces"
--         },
--         options = {
--           enable = true,
--           target = {
--             args = {},
--             installable = "",
--             nixPath = "",
--           },
--         },
--       },
--     },
--     filetypes = { "nix" },
--   }
-- end

return {
  settings = {
    nixd = {
      formatting = {
        command = "nixfmt --no-expand-braces"
      },
      options = {
        enable = true,
        target = {
          args = {},
          installable = "",
          nixPath = "",
        },
      },
    },
  },
  filetypes = { "nix" },
}
