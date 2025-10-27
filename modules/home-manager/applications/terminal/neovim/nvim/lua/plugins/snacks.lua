return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = false },
    git = { enabled = true },
    gitbrowse = { enabled = true },
    indent = {
      enabled = true,
      only_scope = true,
      animate = {
        enabled = false,
      }
    },
    input = { enabled = true },
    picker = {
      enabled = true,
      actions = {
        sidekick_send = function(...)
          return require("sidekick.cli.picker.snacks").send(...)
        end,
      },
      previewers = {
        diff = {
          builtin = false,
          cmd = { "delta" },
        },
        git = {
          builtin = false,
        }
      },
      win = {
        input = {
          keys = {
            ["<a-a>"] = {
              "sidekick_send",
              mode = { "n", "i" },
            },
          },
        },
      },
    },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    -- words = { enabled = true },
  },
  keys = {
    { "<leader>.",  function() Snacks.scratch() end,               desc = "Toggle Scratch Buffer" },
    { "<leader>S",  function() Snacks.scratch.select() end,        desc = "Select Scratch Buffer" },
    { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>gB", function() Snacks.gitbrowse() end,             desc = "Git Browse",           mode = { "n", "v" } },
    { "ff",         function() Snacks.picker.smart() end,          desc = "Smart Find Files" },
  }
}
