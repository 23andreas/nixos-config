local M = {}

-- Use vim.loop to list files in the ls folder
local function load_servers()
  local ls_path = vim.fn.stdpath("config") .. "/lua/language-servers"
  local files = vim.fn.globpath(ls_path, "*.lua", false, true)

  for _, file in ipairs(files) do
    local server = file:match("([^/]+)%.lua$")
    if server and server ~= "init" then
      M[server] = require("language-servers." .. server)
    end
  end
end

load_servers()
return M
