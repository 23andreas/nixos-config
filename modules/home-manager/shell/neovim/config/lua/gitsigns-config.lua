require('gitsigns').setup({
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map('n', '<leader>hd', gitsigns.diffthis, { desc = "Diff this" })
    map('n', '<leader>hD', function() gitsigns.diffthis('~') end, { desc = 'Diff this2?' })

    map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, { desc = "blame line" })
    map('n', '<leader>hB', gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" })

    map('n', '<leader>hp', gitsigns.preview_hunk)

    -- map('n', ']c', function() gitsigns.nav_hunk('next') end, { desc = "Next hunk" })
    -- map('n', '[c', function() gitsigns.nav_hunk('prev') end, { desc = "Prev hunk" })

    local wk = require('which-key')
    wk.add({
      { "<leader>h", group = "Git" }
    })
  end
})
