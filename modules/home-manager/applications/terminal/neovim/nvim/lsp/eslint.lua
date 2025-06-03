return {
  settings = {
    -- useESLintClass = false,
    -- quiet = false, -- Ignore warnings
    -- validate = "on",
    format = true,
    -- nodePath = "",
    codeActionsOnSave = {
      enable = false,
      mode = "all",
    },
    problems = {
      shortenToSingleLine = false,
    },
    experimental = {
      useFlatConfig = false,
    },
    packageManager = nil,
    onIgnoredFiles = "off",
    workingDirectory = { mode = "auto" },
    -- workspaceFolder = get_workspace_folder(),
  },
}
