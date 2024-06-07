local refactoring = require('refactoring')

-- helper function to create a closure for trouble.toggle
local function refactor(name)
  return function()
    refactoring.refactor(name)
  end
end

vim.keymap.set("x", "<leader>re", refactor('Extract Function'), { desc = 'Extract Function' })
vim.keymap.set("x", "<leader>rf", refactor('Extract Function To File'), { desc = "Extract Function To File" })
-- Extract function supports only visual mode

vim.keymap.set("x", "<leader>rv", refactor('Extract Variable'), { desc = 'Extract Variable' })
-- Extract variable supports only visual mode

vim.keymap.set("n", "<leader>rI", refactor('Inline Function'), { desc = 'Inline Function' })
-- Inline func supports only normal mode

vim.keymap.set({ "n", "x" }, "<leader>ri", refactor('Inline Variable'), { desc = 'Inline Variable' })
-- Inline var supports both normal and visual mode

vim.keymap.set("n", "<leader>rb", refactor('Extract Block'), { desc = 'Extract Block' })
vim.keymap.set("n", "<leader>rbf", refactor('Extract Block To File'), { desc = 'Extract Block To File' })
-- Extract block supports only normal mode

