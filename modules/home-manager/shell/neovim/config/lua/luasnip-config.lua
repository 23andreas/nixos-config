local ls = require('luasnip')
require('luasnip.loaders.from_snipmate').load()

vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-H>", function() ls.jump(-1) end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-J>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })