local M = {}

function M.silence_debug()
  local ok, mod = pcall(require, "lsp-file-operations")
  if not ok or type(mod) ~= "table" or not mod.setup then return end

  local orig_setup = mod.setup
  mod.setup = function(opts)
    opts = opts or {}
    opts.debug = false
    return orig_setup(opts)
  end

  -- Stub out the logfile stats function, which has a bug that fires
  -- even when debug = false. Replace it with a no-op after the module loads.
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    once = true,
    callback = function()
      local ok2, log = pcall(require, "lsp-file-operations.log")
      if ok2 and type(log) == "table" and log.get_logfile_stats then
        ---@diagnostic disable-next-line: inject-field
        log.get_logfile_stats = function() return {} end
      end
    end,
  })
end

return M
