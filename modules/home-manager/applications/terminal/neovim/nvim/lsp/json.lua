return {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  settings = {
    json = {
      -- Enable/disable default JSON formatter
      format = { enable = true },
      -- Schema configurations
      schemas = {
        -- Base configs
        {
          fileMatch = { "package.json" },
          url = "https://json.schemastore.org/package.json"
        },
        {
          fileMatch = { "tsconfig*.json" },
          url = "https://json.schemastore.org/tsconfig.json"
        },
        {
          fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
          url = "https://json.schemastore.org/prettierrc.json"
        },
        {
          fileMatch = { ".eslintrc", ".eslintrc.json" },
          url = "https://json.schemastore.org/eslintrc.json"
        },
        -- TypeScript/JavaScript
        {
          fileMatch = { "jsconfig.json" },
          url = "https://json.schemastore.org/jsconfig.json"
        },
        -- React/Frontend
        {
          fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
          url = "https://json.schemastore.org/babelrc.json"
        },
        {
          fileMatch = { "jest.config.json", "jest.json" },
          url = "https://json.schemastore.org/jest.json"
        },
        {
          fileMatch = { ".storybook/main.json" },
          url = "https://json.schemastore.org/storybook-main.json"
        },

        -- NX Monorepo
        {
          fileMatch = { "nx.json" },
          url = "https://raw.githubusercontent.com/nrwl/nx/master/packages/nx/schemas/nx-schema.json"
        },
        {
          fileMatch = { "project.json" },
          url = "https://raw.githubusercontent.com/nrwl/nx/master/packages/nx/schemas/project-schema.json"
        },
        {
          fileMatch = { "workspace.json" },
          url = "https://raw.githubusercontent.com/nrwl/nx/master/packages/nx/schemas/workspace-schema.json"
        },
        -- CI/CD & Development
        {
          fileMatch = { "renovate.json", ".github/renovate.json", ".renovaterc", ".renovaterc.json" },
          url = "https://docs.renovatebot.com/renovate-schema.json"
        },
        -- Docker/Containers
        {
          fileMatch = { ".devcontainer.json", "devcontainer.json", ".devcontainer/devcontainer.json" },
          url =
          "https://raw.githubusercontent.com/microsoft/vscode/main/extensions/configuration-editing/schemas/devContainer.schema.json"
        }
      },
      -- Schemas from schemastore (optional - can be removed if you don't use those schemas)
      schemaDownload = { enable = true },
      -- Validate JSON files even if they have comments
      validate = { enable = true }
    }
  }
}

