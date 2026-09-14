return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "standard", -- standard is less strict
              },
            },
          },
        },
        ruff = {
          -- Ruff only if is configured
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern("ruff.toml", ".ruff.toml")(fname)
              or (function()
                local root = util.root_pattern("pyproject.toml")(fname)
                if root then
                  local f = io.open(root .. "/pyproject.toml")
                  if f then
                    local content = f:read("*a")
                    f:close()
                    if content:find("%[tool%.ruff") then
                      return root
                    end
                  end
                end
              end)()
          end,
        },
      },
    },
  },
}
