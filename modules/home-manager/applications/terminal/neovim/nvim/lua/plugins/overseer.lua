return {
  'stevearc/overseer.nvim',
  opts = {
    strategy = "terminal",                                                     -- or "toggleterm", "jobstart"
    templates = { "builtin" },                                                 -- load built-in templates
    template_dirs = { vim.fn.stdpath("config") .. "/lua/overseer_templates" }, -- custom template directory
    task_list = {
      direction = "bottom",                                                    -- or "left", "right", "top"
      min_height = 10,
      max_height = 20,
      default_detail = 1,
    },
    form = {
      border = "rounded",
    },
    confirm = {
      start = false,
      delete = true,
    },
  },
}
