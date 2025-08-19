return
{
  "mistweaverco/kulala.nvim",
  keys = {
    { "<leader>rs", "<cmd>lua require('kulala').run()<cr>", desc = "Send request" },
    { "<leader>ra", "<cmd>lua require('kulala').run_all()<cr>", desc = "Send all requests" },
    { "<leader>rb", "<cmd>lua require('kulala').scratchpad()<cr>", desc = "Open scratchpad" },
  },
  ft = { "http", "rest" },
  opts = {
    global_keymaps = false,
    global_keymaps_prefix = "<leader>r",
    kulala_keymaps_prefix = "",
  },
}
