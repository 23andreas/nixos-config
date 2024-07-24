require("auto-session").setup {
  log_level = "error",
  auto_restore_enabled = true,
  auto_save_enabled = true,

  cwd_change_handling = {
    restore_upcoming_session = true, -- Disabled by default, set to true to enable
    post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
      require("lualine").refresh() -- refresh lualine so the new session name is displayed in the status bar
    end,
  },
}

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
