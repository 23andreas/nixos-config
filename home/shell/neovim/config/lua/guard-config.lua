local ft = require('guard.filetype')
ft('typescript,javascript,typescriptreact'):fmt('prettier')

require('guard').setup({
  fmt_on_save = false,
})