local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({ buffer = bufnr, preserve_mappings = false })
  require("lsp_signature").on_attach({}, bufnr)
end)

require("lazy-lsp").setup {
  excluded_servers = {
    "tailwindcss",
    "denols",
    "quick_lint_js",
    -- "tsserver"
  },
  preferred_servers = {
    nix = { "nixd" },
  }
}
