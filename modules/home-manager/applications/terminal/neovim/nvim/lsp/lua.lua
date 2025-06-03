-- luals.lua
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc" },
  telemetry = { enable = false },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      signatureHelp = { enabled = true },
    },
  },
}
