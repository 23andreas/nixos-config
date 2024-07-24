-- Attempt to require 'telescope.builtin'
local ok, builtin = pcall(require, "telescope.builtin")
local ok_telescope, telescope = pcall(require, "telescope")
if not ok or not ok_telescope then
  print("Failed to load telescope.builtin")
  return
end

telescope.setup {
  pickers = {
    find_files = {
      hidden = true,
    },
  },
  defaults = {
    path_display = { "truncate" }
  },
  extensions = {
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",
    }
  }
}

telescope.load_extension('fzf');

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "List previously opened files" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
vim.keymap.set("n", "<leader>ft", builtin.colorscheme, { desc = "Colorschemes" })

vim.keymap.set("n", "<leader>rf", builtin.quickfix, { desc = "Quickfixes" })
-- vim.keymap.set("n", "<leader>fs", builtin.treesitter, { desc = "Document symbols" })

vim.keymap.set("n", "<leader>bb", builtin.buffers, { desc = "Buffers" })

vim.keymap.set("n", "<leader>hf", builtin.git_branches, { desc = "Git branches" })
