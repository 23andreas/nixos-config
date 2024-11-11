return {
  {
    'kevinhwang91/nvim-ufo',
    event = "VimEnter",
    dependencies = { "kevinhwang91/promise-async" },
    opts = {
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end
    },

    init = function()
      vim.o.foldenable = true
      vim.o.foldcolumn = '0'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep: ,foldclose:'

      local colors = require("catppuccin.palettes").get_palette()
      vim.api.nvim_set_hl(0, 'FoldBackground', { bg = colors.overlay1, fg = colors.crust, bold = false })
    end,

    config = function(_, opts)
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (' 󰘦  %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { ' ', '' })
        table.insert(newVirtText, { suffix, 'FoldBackground' })
        return newVirtText
      end

      opts.fold_virt_text_handler = handler
      require("ufo").setup(opts)
    end,
  }
}
