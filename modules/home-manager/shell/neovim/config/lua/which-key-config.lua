local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  print("Failed to load which-key")
  return
end

local setup = {}

local mappings = {
  { "<leader>b", group = "Buffer" },
  { "<leader>f", group = "Find" },
  { "<leader>l", group = "Lsp" },
  { "<leader>p", group = "Project" },
  { "<leader>r", group = "Refactor" },
  { "<leader>x", group = "Diagnostics" },
}

wk.setup(setup)
wk.add(mappings)
