return {
  "3rd/diagram.nvim",
  dependencies = {
    "3rd/image.nvim",
    build = false,
    opts = {}
  },
  opts = { -- you can just pass {}, defaults below
    -- integrations = {
    --   require("diagram.integrations.markdown"),
    -- },
    renderer_options = {
      mermaid = {
        background = "transparent", -- nil | "transparent" | "white" | "#hex"
        theme = nil,                -- nil | "default" | "dark" | "forest" | "neutral"
        scale = 1,                  -- nil | 1 (default) | 2  | 3 | ...
      },
      plantuml = {
        charset = nil,
      },
      d2 = {
        theme_id = nil,
        dark_theme_id = nil,
        scale = nil,
        layout = nil,
        sketch = nil,
      },
    }
  },
}
