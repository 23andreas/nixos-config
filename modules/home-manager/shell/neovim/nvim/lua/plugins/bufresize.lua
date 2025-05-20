return
{
  'kwkarlwang/bufresize.nvim',
  opts = {
    register = {
      trigger_events = { 'BufWinEnter', 'WinEnter', 'WinResized' },
    },
    resize = {
      keys = {},
      trigger_events = { 'VimResized' },
      increment = false,
    },
  },
}
