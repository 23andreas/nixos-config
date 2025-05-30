local M = {}

-- Use vim.loop to list files in the ls folder
local function load_servers()
  local ls_path = vim.fn.stdpath("config") .. "/lua/language-servers"
  local files = vim.fn.globpath(ls_path, "*.lua", false, true)
  local servers = {}

  for _, file in ipairs(files) do
    local server = file:match("([^/]+)%.lua$")
    if server and server ~= "init" then
      servers[server] = require("language-servers." .. server)
    end
  end

  return servers
end


local function setup_lsp_servers()
  local lspconfig = require("lspconfig")
  local cmp_capabilities = require('blink.cmp').get_lsp_capabilities()

  local servers = load_servers()

  for server, config in pairs(servers) do
    -- Merge the capabilities into the LSP configuration
    config.capabilities = vim.tbl_deep_extend("force", config.capabilities or {}, cmp_capabilities)
    lspconfig[server].setup(config)
  end
end

setup_lsp_servers()

return M
