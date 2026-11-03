-- ~/.config/nvim/lua/user/obsidian-vaults.lua is necessary. An example:
--
--[[
-- Machine-specific Obsidian vault paths. Adjust per workstation.
return {
  vaults = {
    { name = "hello-obs", path = "~/spaces/text/obs/hello-obs" },
    -- { name = "work-notes", path = "~/spaces/text/obs/work-notes" },
    -- { name = "journal",    path = "~/spaces/text/obs/journal" },
  },
}
]]

local ok, paths = pcall(require, "user.obsidian-vaults")

return {
  "obsidian-nvim/obsidian.nvim",
  enabled = ok and paths.vaults ~= nil and #paths.vaults > 0,
  ft = "markdown",
  opts = function()
    if not ok then return {} end
    return {
      workspaces = paths.vaults,
    }
  end,
}
