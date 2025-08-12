return {
  name = "PNPM NX Serve Charts",
  builder = function()
    return {
      cmd = { "pnpm", "nx", "serve", "charts" },
      name = "PNPM NX Serve Charts",
      components = { "default" },
    }
  end,
  condition = {
    callback = function()
      -- Only enable in your specific project directory
      return vim.loop.cwd():find("fusion") ~= nil
    end,
  },
}
