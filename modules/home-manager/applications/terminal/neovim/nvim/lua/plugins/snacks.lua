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
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        -- {
        --   pane = 2,
        --   section = "terminal",
        --   cmd = "colorscript -e square",
        --   height = 5,
        --   padding = 1,
        -- },
        { section = "keys",  gap = 1, padding = 1 },
        {
          pane = 2,
          icon = " ",
          desc = "Browse Repo",
          padding = 1,
          key = "b",
          action = function()
            Snacks.gitbrowse()
          end,
        },
        function()
          local in_git = Snacks.git.get_root() ~= nil
          local cmds = {
            -- {
            --   title = "Notifications",
            --   cmd = "gh notify -s -a -n5",
            --   action = function()
            --     vim.ui.open("https://github.com/notifications")
            --   end,
            --   key = "n",
            --   icon = " ",
            --   height = 5,
            --   enabled = true,
            -- },
            -- {
            --   title = "Open Issues",
            --   cmd = "gh issue list -L 3",
            --   key = "i",
            --   action = function()
            --     vim.fn.jobstart("gh issue list --web", { detach = true })
            --   end,
            --   icon = " ",
            --   height = 7,
            -- },
            -- {
            {
              icon = " ",
              title = "Open PRs",
              cmd = "gh pr list -L 3 | awk 'NR>1' | cat",
              key = "P",
              action = function()
                vim.fn.jobstart('gh pr list --web', { detach = true })
              end,
              height = 7,
            },
            {
              icon = " ",
              title = "Git Status",
              cmd = "git --no-pager diff --stat -B -M -C",
              height = 10,
            },
          }
          return vim.tbl_map(function(cmd)
            return vim.tbl_extend("force", {
              pane = 2,
              section = "terminal",
              enabled = in_git,
              padding = 1,
              ttl = 5 * 60,
              indent = 3,
            }, cmd)
          end, cmds)
        end,
        { section = "startup" },
      },

    },
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
    { "<leader>.",        function() Snacks.scratch() end,                       desc = "Toggle Scratch Buffer" },
    { "<leader>S",        function() Snacks.scratch.select() end,                desc = "Select Scratch Buffer" },
    { "<leader>n",        function() Snacks.notifier.show_history() end,         desc = "Notification History" },
    { "<leader>gB",       function() Snacks.gitbrowse() end,                     desc = "Git Browse",                 mode = { "n", "v" } },

    { "<leader><leader>", function() Snacks.picker.smart() end,                  desc = "Smart Find Files" },
    { "<leader>,",        function() Snacks.picker.buffers() end,                desc = "Buffers" },
    { "<leader>/",        function() Snacks.picker.grep() end,                   desc = "Grep" },
    { "<leader>:",        function() Snacks.picker.command_history() end,        desc = "Command History" },
    -- { "<leader>jf",       function() Snacks.picker.files() end,           desc = "Find Files" },
    { "<leader>fo",       function() Snacks.picker.recent() end,                 desc = "Recent" },
    { "<leader>fr",       function() Snacks.picker.lsp_references() end,         nowait = true,                       desc = "References" },


    { "<leader>gb",       function() Snacks.picker.git_branches() end,           desc = "Git Branches" },
    { "<leader>gl",       function() Snacks.picker.git_log() end,                desc = "Git Log" },
    { "<leader>gL",       function() Snacks.picker.git_log_line() end,           desc = "Git Log Line" },
    { "<leader>gs",       function() Snacks.picker.git_status() end,             desc = "Git Status" },
    { "<leader>gS",       function() Snacks.picker.git_stash() end,              desc = "Git Stash" },
    { "<leader>gd",       function() Snacks.picker.git_diff() end,               desc = "Git Diff (Hunks)" },
    { "<leader>gf",       function() Snacks.picker.git_log_file() end,           desc = "Git Log File" },

    { "<leader>sw",       function() Snacks.picker.grep_word() end,              desc = "Visual selection or word",   mode = { "n", "x" } },

    { "<leader>u",        function() Snacks.picker.undo() end,                   desc = "Undo History" },

    { "<leader>gp",       function() Snacks.picker.gh_pr() end,                  desc = "GitHub Pull Requests (open)" },
    { "<leader>gP",       function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },

  }
}
