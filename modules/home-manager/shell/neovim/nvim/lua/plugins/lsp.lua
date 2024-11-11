return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    opts = {
      diagnostics = {
        -- underline = true,
        -- update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
      },
      inlay_hints = {
        enabled = true,
      },
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = false,
              },
              completion = {
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          },
        },
        ts_ls = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayVariableTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayVariableTypeHints = true,

                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            }
          }
        },
        nixd = {},
      },
    },
    config = function(_, opts)
      vim.diagnostic.config(opts.diagnostics)

      -- Loop through each server in opts.servers and set it up
      local lspconfig = require("lspconfig")
      for server, server_opts in pairs(opts.servers) do
        local options = vim.tbl_deep_extend("force", {
          capabilities = opts.capabilities,
          on_attach = function(client, buffer)
            local keymap_opts = { noremap = true, silent = true, buffer = buffer }
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)

            -- Enable codelens if available
            -- if opts.codelens.enabled and vim.lsp.codelens then
            --   vim.lsp.codelens.refresh()
            --   vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
            --     buffer = buffer,
            --     callback = vim.lsp.codelens.refresh,
            --   })
            -- end

            -- if opts.inlay_hints.enabled and client.server_capabilities.inlayHintProvider then
            --   local exclude = opts.inlay_hints.exclude or {}
            --   if
            --       vim.api.nvim_buf_is_valid(buffer)
            --       and vim.bo[buffer].buftype == ""
            --       and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
            --   then
            --     vim.lsp.inlay_hint(buffer, true)
            --   end
            -- end
          end,
        }, server_opts)

        lspconfig[server].setup(options)
      end
    end,
  }
}
