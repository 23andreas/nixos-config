return {
  {
    "zbirenbaum/copilot.lua",
    patch = "copilot.lua.diff",
    dependencies = {
      {
        "copilotlsp-nvim/copilot-lsp",
        init = function()
          -- Set debounce before plugin loads
          vim.g.copilot_nes_debounce = 500
        end,
      },
    },
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    opts = {
      lsp_binary = vim.fn.exepath("copilot-language-server"),
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>"
        },
        layout = {
          position = "bottom", -- | top | left | right
          ratio = 0.4
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        keymap = {
          accept = "<M-;>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          -- dismiss = "<C-]>",
        },
      },
      nes = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept_and_goto = "<tab>",
          accept = false,
          dismiss = "<Esc>"
        }
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
      -- TODO Fix this hack
      copilot_node_command = "/etc/profiles/per-user/andreas/bin/node",
      server_opts_overrides = {},
    },
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
  }
}
