-- Save marks
vim.opt.viminfo = "'100,f20"

-- Set the number of spaces to use for each step of (auto)indent
vim.opt.shiftwidth = 2

-- Set the number of spaces that a <Tab> in the file counts for
vim.opt.tabstop = 2

-- Convert tabs to spaces
vim.opt.expandtab = true

-- DISABLE SWAP FILE
vim.opt.swapfile = false
vim.opt.backup = false

-- UNDO FILE - ENABLE UNDO AFTER REOPENING
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- enable inc search shows matches as you type
vim.opt.incsearch = true

-- enable true colors in terminal
vim.opt.termguicolors = true

-- scroll offset
vim.opt.scrolloff = 8

-- performance
vim.opt.updatetime = 50

-- vertical line at 80
-- vim.opt.colorcolumn = "80"

-- cursor line
vim.opt.cursorline = false

-- smart case
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- auto indent
-- vim.opt.autoindent = true
vim.opt.smartindent = false

-- Hide command line
vim.o.cmdheight = 0

-- Always display sign column, prevent window from "jumping"
vim.o.signcolumn = "yes";

vim.diagnostic.config({
  underline = false,
  update_in_insert = false,
  -- virtual_text = false,
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  },
  signs = false,
  severity_sort = true,
})

-- Diagnositc gutter icons instead of letters
vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
--
-- GBrowse
-- vim.api.nvim_create_user_command(
--   'Browse',
--   function(opts)
--     vim.fn.system { 'xdg-open', opts.fargs[1] }
--   end,
--   { nargs = 1 }
-- )
--

-- Set the diff options
vim.opt.diffopt:append("internal,filler,closeoff,indent-heuristic,linematch:60,algorithm:histogram")
