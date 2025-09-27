-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.py" },
  group = vim.api.nvim_create_augroup("buf_write_post_ruff_fix_format_sort", { clear = true }),
  callback = function()
    -- fixAll
    if vim.bo.filetype == "python" then
      vim.lsp.buf.code_action({
        context = {
          only = { "source.fixAll.ruff" },
        },
        apply = true,
      })
    end
    -- format
    vim.lsp.buf.format({ async = vim.bo.filetype ~= "python" })
    -- organizeImports
    if vim.bo.filetype == "python" then
      vim.lsp.buf.code_action({
        context = {
          only = { "source.organizeImports.ruff" },
        },
        apply = true,
      })
    end
  end,
})

-- Allows ruff to disable hover in favor of pyright
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == "ruff" then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = "LSP: Disable hover capability from Ruff",
})
