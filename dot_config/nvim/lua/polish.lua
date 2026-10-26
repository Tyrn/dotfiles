-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--y   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }

-- vim.o.cmdheight = 0

-- Spell settings
vim.opt.spelllang = { "ru_ru", "en_us", "es_es" }

-- Neovide settings
vim.g.neovide_scale_factor = vim.g.neovide_min_scale_factor

-- Permanently intercept and force debug = false for lsp-file-operations
local orig_require = require
---@diagnostic disable-next-line: duplicate-set-field
_G.require = function(modname)
  local module = orig_require(modname)
  if modname == "lsp-file-operations" and type(module) == "table" and module.setup then
    local orig_setup = module.setup
    module.setup = function(opts)
      opts = opts or {}
      opts.debug = false -- Force off
      orig_setup(opts)
    end
  end
  return module
end

-- Massive remappings
local scraps = require "aa-scraps"

scraps.kinks() -- Assorted exotics, mostly Insert Mode
scraps.odds() -- AstroNvim standard mappings, Cyrillic
