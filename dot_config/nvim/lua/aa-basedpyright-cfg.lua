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
  vim.lsp.config("basedpyright", {
    before_init = function(params, config)
      -- config.root_dir is the workspace root determined by root_markers
      local root = config.root_dir
      if not root then return end

      local venv_python = root .. "/.venv/bin/python"
      if vim.fn.executable(venv_python) == 1 then
        -- Inject pythonPath into the initialization parameters
        params.settings = params.settings or {}
        params.settings.python = params.settings.python or {}
        params.settings.python.pythonPath = venv_python
      end
    end,
  })
end

return M
