local M = {}

-- function M.setup()
--   -- vim.lsp.config merges settings into the server's config
--   -- without requiring the deprecated lspconfig framework.
--   vim.lsp.config("basedpyright", {
--     on_new_config = function(config, root_dir)
--       -- Check for a local .venv and set pythonPath if found
--       local venv_python = root_dir .. "/.venv/bin/python"
--       if vim.fn.executable(venv_python) == 1 then
--         config.settings = config.settings or {}
--         config.settings.python = config.settings.python or {}
--         config.settings.python.pythonPath = venv_python
--       end
--     end,
--   })
-- end

function M.setup()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if not client or client.name ~= "basedpyright" then return end

      local root = client.config.root_dir or vim.fn.getcwd()
      local venv_python = root .. "/.venv/bin/python"
      if vim.fn.executable(venv_python) ~= 1 then return end

      -- Update the running client's settings
      client.config.settings =
        vim.tbl_deep_extend("force", client.config.settings or {}, { python = { pythonPath = venv_python } })

      -- Tell the server to reload its configuration
      client:notify("workspace/didChangeConfiguration", { settings = nil })
    end,
  })
end

return M
