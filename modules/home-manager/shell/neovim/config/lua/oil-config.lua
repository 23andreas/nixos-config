local ok, oil = pcall(require, "oil")
if not ok then
  print("Failed to load oil")
  return
end

vim.keymap.set("n", "<leader>E", oil.open, { desc = "Open oil" })

oil.setup({
  view_options = {
    show_hidden = true
  }
})
