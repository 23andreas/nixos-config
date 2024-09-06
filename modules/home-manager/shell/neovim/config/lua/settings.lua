require("catppuccin").setup({
  transparent_background = true,
  no_italic = true,
  falvour = "mocha",
})

function SetColorScheme(color)
  color = color or "catppuccin"
  vim.cmd.colorscheme(color)

  -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

SetColorScheme()

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- LINE NUMBER SETTINGS
vim.wo.number = true

local numbertoggle_group = augroup('numbertoggle', { clear = true })

autocmd(
  { 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
    pattern = '*',
    callback = function()
      if vim.wo.number and vim.api.nvim_get_mode().mode ~= 'i' then
        vim.wo.relativenumber = true
      end
    end,
    group = numbertoggle_group
  }
)

autocmd(
  { 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
    pattern = '*',
    callback = function()
      if vim.wo.number then
        vim.wo.relativenumber = false
      end
    end,
    group = numbertoggle_group
  }
)

-- HIGLIGHT TEXT WHEN YANKED
local yank_group = augroup('HighlighYank', {})
autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 200,
    })
  end,
})

-- REMOVE TRAILING WHITESPACES ON WRITE
local whitespace_group = augroup('WhitespaceGroup', { clear = true })
autocmd('BufWritePre', {
  group = whitespace_group,
  pattern = '*',
  command = [[%s/\s\+$//e]],
})

-- Diagnositc gutter icons instead of letters
vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

--- GBrowse
vim.api.nvim_create_user_command(
  'Browse',
  function(opts)
    vim.fn.system { 'xdg-open', opts.fargs[1] }
  end,
  { nargs = 1 }
)

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
vim.opt.autoindent = true

-- Hide command line
vim.o.cmdheight = 0
