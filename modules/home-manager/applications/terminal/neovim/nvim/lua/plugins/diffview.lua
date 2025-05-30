return
{
  "sindrets/diffview.nvim",
  event = "VeryLazy",
  opts = {
    enhanced_diff_hl = true,
  },
  keys = {
    {
      "<leader>dd",
      mode = "n",
      "<cmd>DiffviewOpen<CR>",
      desc = "Diff view"
    },
    {
      "<leader>dm",
      mode = "n",
      function()
        local branch = vim.fn.systemlist("git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'")
            [1]
        if branch == "" then
          branch = "main" -- Fallback if the command fails
        end
        vim.cmd("DiffviewOpen origin/" .. branch .. "...HEAD")
      end,
      desc = "Diff against origin/master"
    },
    {
      "<leader>db",
      mode = "n",
      function()
        require("telescope.pickers").new({}, {
          prompt_title = "Select Branch for Diffview",
          finder = require("telescope.finders").new_table {
            results = vim.fn.systemlist("git branch --all | sed 's/^[ *]*//'"),
          },
          sorter = require("telescope.config").values.generic_sorter({}),
          attach_mappings = function(prompt_bufnr, map)
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")

            map("i", "<CR>", function()
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()[1]
              vim.cmd("DiffviewOpen " .. selection .. "...HEAD")
            end)

            map("n", "<CR>", function()
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()[1]
              vim.cmd("DiffviewOpen " .. selection .. "...HEAD")
            end)

            return true
          end,
        }):find()
      end,
      desc = "Diff against selected branch"
    },
    {
      "<leader>df",
      mode = "n",
      "<cmd>DiffviewFileHistory %<CR>",
      desc = "File history"
    },
    {
      "<leader>dF",
      mode = "n",
      "<cmd>DiffviewFileHistory<CR>",
      desc = "File history branch"
    }
  },
  config = true
}
