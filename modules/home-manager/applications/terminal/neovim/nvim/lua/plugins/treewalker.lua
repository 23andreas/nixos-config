return {
  'aaronik/treewalker.nvim',
  opts = {
    -- Whether to briefly highlight the node after jumping to it
    highlight = true,

    -- How long should above highlight last (in ms)
    highlight_duration = 250,

    -- The color of the above highlight. Must be a valid vim highlight group.
    -- (see :h highlight-group for options)
    highlight_group = 'CursorLine',

    -- Whether the plugin adds movements to the jumplist -- true | false | 'left'
    --  true: All movements more than 1 line are added to the jumplist. This is the default,
    --        and is meant to cover most use cases. It's modeled on how { and } natively add
    --        to the jumplist.
    --  false: Treewalker does not add to the jumplist at all
    --  "left": Treewalker only adds :Treewalker Left to the jumplist. This is usually the most
    --          likely one to be confusing, so it has its own mode.
    jumplist = true,
  },
  keys = {
    -- movement
    { '<A-k>',   '<cmd>Treewalker Up<cr>',        mode = { 'n', 'v' }, silent = true },
    { '<A-j>',   '<cmd>Treewalker Down<cr>',      mode = { 'n', 'v' }, silent = true },
    { '<A-h>',   '<cmd>Treewalker Left<cr>',      mode = { 'n', 'v' }, silent = true },
    { '<A-l>',   '<cmd>Treewalker Right<cr>',     mode = { 'n', 'v' }, silent = true },
    -- swapping
    { '<A-S-k>', '<cmd>Treewalker SwapUp<cr>',    mode = 'n',          silent = true },
    { '<A-S-j>', '<cmd>Treewalker SwapDown<cr>',  mode = 'n',          silent = true },
    { '<A-S-h>', '<cmd>Treewalker SwapLeft<cr>',  mode = 'n',          silent = true },
    { '<A-S-l>', '<cmd>Treewalker SwapRight<cr>', mode = 'n',          silent = true },
  }
}
