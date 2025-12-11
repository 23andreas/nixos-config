-- Rustacean.nvim keymaps
local bufnr = vim.api.nvim_get_current_buf()

-- Register with which-key
local wk_ok, wk = pcall(require, "which-key")
if wk_ok then
  wk.add({
    { "K",           desc = "Hover actions",        buffer = bufnr },
    { "gd",          desc = "Go to definition",     buffer = bufnr },
    { "gD",          desc = "Go to declaration",    buffer = bufnr },
    { "gi",          desc = "Go to implementation", buffer = bufnr },
    { "gr",          desc = "Go to references",     buffer = bufnr },
    { "grn",         desc = "Rename",               buffer = bufnr },
    { "gra",         desc = "Code action",          buffer = bufnr },
    { "<leader>le",  group = "Explain",             buffer = bufnr },
    { "<leader>lem", desc = "Expand macro",         buffer = bufnr },
    { "<leader>lee", desc = "Explain error",        buffer = bufnr },
    { "<leader>lr",  group = "Run/Cargo",           buffer = bufnr },
    { "<leader>lrd", desc = "Open Cargo.toml",      buffer = bufnr },
    { "<leader>lrr", desc = "Runnables",            buffer = bufnr },
    { "<leader>lrt", desc = "Testables",            buffer = bufnr },
    { "<leader>lrc", desc = "Open docs",            buffer = bufnr },
    { "<leader>lp",  group = "Parent",              buffer = bufnr },
    { "<leader>lpm", desc = "Parent module",        buffer = bufnr },
    { "<leader>lj",  group = "Join",                buffer = bufnr },
    { "<leader>ljl", desc = "Join lines",           buffer = bufnr },
    { "<leader>lh",  group = "Hover",               buffer = bufnr },
    { "<leader>lha", desc = "Hover actions",        buffer = bufnr },
    { "<leader>lv",  group = "View",                buffer = bufnr },
    { "<leader>lvh", desc = "View HIR",             buffer = bufnr },
    { "<leader>lvm", desc = "View MIR",             buffer = bufnr },
  })
end

-- LSP basics (using rustacean-enhanced versions)
vim.keymap.set("n", "K", function()
  vim.cmd.RustLsp({ "hover", "actions" })
end, { silent = true, buffer = bufnr })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true, buffer = bufnr })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true, buffer = bufnr })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { silent = true, buffer = bufnr })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { silent = true, buffer = bufnr })
vim.keymap.set("n", "grn", vim.lsp.buf.rename, { silent = true, buffer = bufnr })

-- LSP actions
vim.keymap.set("n", "gra", function()
  vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
end, { silent = true, buffer = bufnr })

-- Rust-specific actions under <leader>l
vim.keymap.set("n", "<leader>lem", function()
  vim.cmd.RustLsp("expandMacro")
end, { silent = true, buffer = bufnr })
vim.keymap.set("n", "<leader>lee", function()
  vim.cmd.RustLsp("explainError")
end, { silent = true, buffer = bufnr })
vim.keymap.set("n", "<leader>lrd", function()
  vim.cmd.RustLsp("openCargo")
end, { silent = true, buffer = bufnr })
vim.keymap.set("n", "<leader>lpm", function()
  vim.cmd.RustLsp("parentModule")
end, { silent = true, buffer = bufnr })
vim.keymap.set("n", "<leader>ljl", function()
  vim.cmd.RustLsp("joinLines")
end, { silent = true, buffer = bufnr })
vim.keymap.set("n", "<leader>lha", function()
  vim.cmd.RustLsp({ "hover", "actions" })
end, { silent = true, buffer = bufnr })
vim.keymap.set("n", "<leader>lvh", function()
  vim.cmd.RustLsp({ "view", "hir" })
end, { silent = true, buffer = bufnr })
vim.keymap.set("n", "<leader>lvm", function()
  vim.cmd.RustLsp({ "view", "mir" })
end, { silent = true, buffer = bufnr })

-- Cargo commands under <leader>l
vim.keymap.set("n", "<leader>lrr", function()
  vim.cmd.RustLsp("runnables")
end, { silent = true, buffer = bufnr })
vim.keymap.set("n", "<leader>lrt", function()
  vim.cmd.RustLsp("testables")
end, { silent = true, buffer = bufnr })
vim.keymap.set("n", "<leader>lrc", function()
  vim.cmd.RustLsp("openDocs")
end, { silent = true, buffer = bufnr })
