local neogit = require('neogit')
neogit.setup {
  telescope_sorter = function()
    return require("telescope").extensions.fzf.native_fzf_sorter()
  end,
}

vim.keymap.set({ 'n', 'v' }, '<leader>hh', function()
  neogit.open({ kind = "auto" })
end, { desc = "Neogit" })
