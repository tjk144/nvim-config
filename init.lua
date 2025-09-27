-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("lspconfig").basedpyright.setup({
  name = "basedpyright",
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_dir = require("lspconfig.util").root_pattern("pyproject.toml", ".git"),
  single_file_support = true,
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      analysis = {
        diagnosticMode = "workspace",
      },
    },
  },
})
-- vim.lsp.enable("pyrefly")
