local trouble_telescope = require("trouble.providers.telescope")
local telescope = require("telescope")

telescope.setup {
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble_telescope.open_with_trouble },
      n = { ["<c-t>"] = trouble_telescope.open_with_trouble },
    },
  },
}

-- helper function to create a closure for trouble.toggle
local trouble = require("trouble")
local function create_trouble_toggle(mode)
  return function()
    trouble.toggle(mode)
  end
end

vim.keymap.set("n", "<leader>xx", create_trouble_toggle(), { desc = "Toggle trouble" })
vim.keymap.set("n", "<leader>xw", create_trouble_toggle("workspace_diagnostics"), { desc = "Workspace diagnostics" })
vim.keymap.set("n", "<leader>xd", create_trouble_toggle("document_diagnostics"), { desc = "Document diagnostics" })
vim.keymap.set("n", "<leader>xq", create_trouble_toggle("quickfix"), { desc = "Quickfix" })
vim.keymap.set("n", "<leader>xl", create_trouble_toggle("loclist"), { desc = "Loclist" })
vim.keymap.set("n", "gR", create_trouble_toggle("lsp_references"), { desc = "Lsp references" })
