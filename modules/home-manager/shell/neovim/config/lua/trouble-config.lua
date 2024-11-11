local trouble_telescope = require("trouble.sources.telescope")
local telescope = require("telescope")

telescope.setup {
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble_telescope.open },
      n = { ["<c-t>"] = trouble_telescope.open },
    },
  },
}

-- helper function to create a closure for trouble.toggle
local opts = {
  modes = {
    preview_float = {
      mode = "diagnostics",
      preview = {
        type = "float",
        relative = "editor",
        border = "rounded",
        title = "Preview",
        title_pos = "center",
        position = { 0, -2 },
        size = { width = 0.3, height = 0.3 },
        zindex = 200,
      },
    },
  },
}

require("trouble").setup(opts)

local function create_trouble_toggle(mode)
  return function()
    require("trouble").toggle(mode)
  end
end

vim.keymap.set("n", "<leader>x", create_trouble_toggle("diagnostics"), { desc = "Toggle trouble" })
-- vim.keymap.set("n", "gR", create_trouble_toggle("lsp_references"), { desc = "lsp references" })
