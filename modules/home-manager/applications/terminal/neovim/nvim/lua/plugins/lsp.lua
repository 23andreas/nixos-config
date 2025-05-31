return {
  {
    "neovim/nvim-lspconfig",
    event = "bufreadpre",
    config = function()
      -- todo move these to keybinds?
      vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>",
        { noremap = true, silent = true, desc = "diagnostic go to prev" })
      vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>",
        { noremap = true, silent = true, desc = "diagnostic go to next" })

      local format_on_save = true
      local function toggle_format_on_save()
        format_on_save = not format_on_save
      end

      vim.keymap.set("n", "<leader>tf", toggle_format_on_save,
        { noremap = true, silent = true, desc = "format on save" })

      -- keybindings for lsp actions
      local setup_keybindings = function(client, bufnr)
        local buf_map = function(mode, lhs, rhs, opts)
          opts = opts or { noremap = true, silent = true }
          vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
        end

        -- lsp keybindings
        buf_map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
        buf_map("n", "gD", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
        buf_map("n", "k", "<cmd>lua vim.lsp.buf.hover()<cr>")
        buf_map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
        buf_map("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>")
        buf_map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>")
        buf_map("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
        buf_map("n", "<leader>ld", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "show diagnostics" })

        -- toggle inlay_hint
        if vim.lsp.inlay_hint then
          vim.keymap.set("n", "<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, { desc = "inlay hints" })
        end

        -- auto-format on save if format_on_save is true
        if client.server_capabilities.documentformattingprovider then
          vim.api.nvim_create_autocmd("bufwritepre", {
            buffer = bufnr,
            callback = function()
              if format_on_save then
                vim.lsp.buf.format({ async = false })
              end
            end,
          })
        end
      end

      local servers = require("language-servers")
      for _, setup in pairs(servers) do
        setup(setup_keybindings)
      end
    end,
  },
}
