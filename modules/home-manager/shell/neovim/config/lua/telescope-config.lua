-- Attempt to require 'telescope.builtin'
local ok, builtin = pcall(require, "telescope.builtin")
local ok_telescope, telescope = pcall(require, "telescope")
local custom_pickers = require 'telescope-custom-pickers'

if not ok or not ok_telescope then
  print("Failed to load telescope.builtin")
  return
end

telescope.setup {
  pickers = {
    find_files = {
      hidden = true,
      find_command = {
        'rg',
        '--files',
        '--color',
        'never',
      },
    },
    oldfiles = {
      sort_lastused = true,
    },
    live_grep = {
      mappings = {
        i = {
          ['<c-f>'] = custom_pickers.actions.set_extension,
          ['<c-l>'] = custom_pickers.actions.set_folders,
        },
      },
    }
  },
  defaults = {
    path_display = { "smart" },
    layout_config = {
      horizontal = {
        width = 0.97,
        height = 0.97
      }
    },
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
-- telescope.load_extension('smart_open');
-- telescope.load_extension('ui-select');

-- vim.keymap.set("n", "<leader><leader>", function()
-- require('telescope').extensions.smart_open.smart_open()
-- end, { noremap = true, silent = true })
-- vim.keymap.set("n", "<leader><leader>", telescope.extensions.smart_open.smart_open, { desc = "Find Files" })

vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", custom_pickers.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "List previously opened files" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
vim.keymap.set("n", "<leader>ft", builtin.colorscheme, { desc = "Colorschemes" })

vim.keymap.set("n", "<leader>bb", builtin.buffers, { desc = "Buffers" })

vim.keymap.set("n", "<leader>hf", builtin.git_branches, { desc = "Git branches" })

vim.keymap.set("n", "<leader>fj", builtin.jumplist, { desc = "Jumplist" })
vim.keymap.set("n", "<leader>fr", builtin.registers, { desc = "Registers" })

vim.keymap.set("n", "<leader>fl", builtin.lsp_references, { desc = "lsp references" })
vim.keymap.set("n", "<leader>fp", builtin.lsp_document_symbols, { desc = "Document symbols" })
vim.keymap.set("n", "<leader>fx", builtin.diagnostics, { desc = "diagnostics" })

local colors = require("catppuccin.palettes").get_palette()

-- background = "#1F2733";
local bgColor = "#27313F";
local selectionColor = "#2F3A4C";

-- local promptColor = "#1F2733";

local TelescopeColor = {
  TelescopeMatching = { fg = colors.blue },
  TelescopeSelection = { fg = colors.text, bg = selectionColor, bold = true },

  TelescopePromptTitle = { bg = selectionColor, fg = selectionColor },
  TelescopePromptBorder = { bg = selectionColor, fg = selectionColor },
  TelescopePromptPrefix = { bg = selectionColor },
  TelescopePromptNormal = { bg = selectionColor },

  TelescopePreviewTitle = { bg = bgColor, fg = bgColor },
  TelescopePreviewNormal = { bg = bgColor },
  TelescopePreviewBorder = { bg = bgColor, fg = bgColor },

  TelescopeResultsTitle = { fg = bgColor },
  TelescopeResultsBorder = { bg = bgColor, fg = bgColor },
  TelescopeResultsNormal = { bg = bgColor },
}

for hl, col in pairs(TelescopeColor) do
  vim.api.nvim_set_hl(0, hl, col)
end
