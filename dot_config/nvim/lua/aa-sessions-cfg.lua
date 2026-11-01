-- Make the "Last Session" mapping load the current directory's session
-- instead of the global "Last Session" file.
--
-- AstroNvim saves two kinds of sessions on exit: a per-directory one
-- (named after the cwd) and a single global one ("Last Session"). The
-- `<Leader>Sl` mapping and the dashboard "s" shortcut both load the
-- global one by default, which is why opening a new project can pull in
-- buffers from an unrelated directory. This override makes `<Leader>Sl`
-- load the per-directory session for the current working directory.
local M = {}

function M.setup()
  vim.schedule(function()
    vim.keymap.set(
      "n",
      "<Leader>Sl",
      function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession" }) end,
      { desc = "Load current dirsession (overridden)" }
    )
  end)
end

return M
