-- Function to open the current file on GitHub
local function open_on_github(branch, start_line, end_line)
  -- Get the file path relative to the git root
  local filepath = vim.fn.expand('%')
  local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  local relative_path = vim.fn.fnamemodify(filepath, ':~:.'):gsub('^' .. git_root, '')

  -- Get the Git remote URL
  local remote_url = vim.fn.systemlist('git remote get-url origin')[1]
  remote_url = remote_url:gsub("%.git$", ""):gsub("^git@github.com:", "https://github.com/")

  -- Construct the URL to open in the browser
  local github_url = string.format("%s/blob/%s/%s", remote_url, branch, relative_path)

  -- If start and end lines are provided, add them to the URL for highlighting
  if start_line and end_line then
    github_url = string.format("%s#L%d-L%d", github_url, start_line, end_line)
  end

  -- Open the URL in the default browser
  vim.fn.system({ 'xdg-open', github_url })
end

-- Normal mode keybinding to open on GitHub master
vim.keymap.set('n', '<leader>ho', function()
  open_on_github("master")
end, { noremap = true, silent = true })

-- Normal mode keybinding to open on GitHub current branch
vim.keymap.set('n', '<leader>hO', function()
  open_on_github(vim.fn.systemlist("git branch --show-current")[1])
end, { noremap = true, silent = true })

-- Visual mode keybinding to open selected lines on GitHub master
vim.keymap.set('v', '<leader>ho', function()
  open_on_github("master", vim.fn.line("v"), vim.fn.line("."))
end, { noremap = true, silent = true })

-- Visual mode keybinding to open selected lines on GitHub current branch
vim.keymap.set('v', '<leader>hO', function()
  open_on_github(vim.fn.systemlist("git branch --show-current")[1], vim.fn.line("v"), vim.fn.line("."))
end, { noremap = true, silent = true })

