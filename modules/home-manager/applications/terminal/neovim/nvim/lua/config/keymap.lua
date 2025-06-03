-- TODO CLEANUP
vim.g.mapleader = " "

-- Quit vim
vim.keymap.set({ "n", "x", "v" }, "<leader>q", ":qall<CR>", { desc = "Quit" })
vim.keymap.set({ "n", "x", "v" }, "<leader>Q", ":qall!<CR>", { desc = "Quit without saving" })

-- Paste without replacing register in visual mode
-- vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without losing register" })

-- Delete without storing in register
-- vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without register" })

-- Copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy line to system clipboard" })

-- Center search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Center when scrolling page with <C-d> and <C-u>
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Buffer
vim.keymap.set("n", "<leader>bw", ":w<CR>", { desc = "Buffer write" })
vim.keymap.set("n", "<leader>bf", function() vim.lsp.buf.format({ async = false }) end, { desc = "Buffer format" })

-- Toggle line wrap
vim.keymap.set("n", "<leader>tw", ":set wrap!<CR>", { desc = "Toggle line wrap" })

-- Navigate windows
-- vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })

-- Navigate windows in terminal mode as well
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h', { silent = true })
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j', { silent = true })
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k', { silent = true })
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l', { silent = true })

-- Resize windows
vim.keymap.set("n", "<C-M-h>", ":vertical resize -10<CR>", { silent = true })
vim.keymap.set("n", "<C-M-l>", ":vertical resize +10<CR>", { silent = true })
vim.keymap.set("n", "<C-M-j>", ":resize +10<CR>", { silent = true })
vim.keymap.set("n", "<C-M-k>", ":resize -10<CR>", { silent = true })

-- Create an autocommand to set keymaps for oil.nvim
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'oil',
  callback = function()
    -- Navigate windows in oil.nvim
    vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true, buffer = true })
    vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true, buffer = true })
    vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true, buffer = true })
    vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true, buffer = true })
  end
})

-- Clear search highlight ESC
vim.keymap.set("n", "<ESC>", ":noh<CR>", { silent = true })

-- Git browse
-- vim.keymap.set({ 'n', 'v' }, '<leader>ho', vim.cmd.GBrowse, { desc = "Open in github" })
-- vim.keymap.set({ 'n', 'v' }, '<leader>hO', ":GBrowse origin/master:%<CR>", { desc = "Open in github master" })

-- ESC in terminal
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

-- Global diagnostic navigation
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>",
  { noremap = true, silent = true, desc = "Diagnostic: Go to previous" })
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>",
  { noremap = true, silent = true, desc = "Diagnostic: Go to next" })
vim.keymap.set("n", "<leader>ld", "<cmd>lua vim.diagnostic.open_float()<CR>",
  { noremap = true, silent = true, desc = "Diagnostic: Show diagnostics" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- Go to definition and type definition
    -- vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    -- vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)

    -- Hover and references
    -- vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    -- vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

    -- Code action and rename
    -- vim.keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    -- vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

    -- Signature help
    -- vim.keymap.set("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

    -- Toggle inlay hints (only if supported)
    if vim.lsp.inlay_hint then
      vim.keymap.set("n", "<leader>th", function()
        -- Toggle inlay hints on or off for this buffer
        if vim.lsp.inlay_hint.is_enabled(bufnr) then
          vim.lsp.inlay_hint.disable(bufnr)
        else
          vim.lsp.inlay_hint.enable(bufnr)
        end
      end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))
    end
  end,
})
