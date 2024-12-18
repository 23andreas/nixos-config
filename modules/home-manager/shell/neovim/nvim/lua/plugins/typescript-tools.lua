local setup_keybindings = function(client, bufnr)
  local buf_map = function(mode, lhs, rhs, opts)
    opts = opts or { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
  end

  -- LSP keybindings
  buf_map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  buf_map("n", "gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
  buf_map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  buf_map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  buf_map("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  buf_map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>")
  buf_map("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  buf_map("n", "<leader>ld", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Show diagnostics" })

  -- Toggle inlay_hint
  if vim.lsp.inlay_hint then
    vim.keymap.set("n", "<Leader>th", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { desc = "Inlay hints" })
  end

  -- Auto-format on save if format_on_save is true
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        if format_on_save then
          vim.lsp.buf.format({ async = false })
        end
      end,
    })
  end
end

return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      on_attach = function(client, bufnr)
        -- Disable tsserver's formatting
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        setup_keybindings(client, bufnr)
      end,
    },
  }
}
