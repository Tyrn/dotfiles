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

-- May become unnecessary when the upstream bug is fixed
-- (antosha417/nvim-lsp-file-operations plugin)
require("aa-lsp-file-ops").silence_debug()

-- Massive remappings
local scraps = require "aa-scraps"

scraps.kinks() -- Assorted exotics, mostly Insert Mode
scraps.odds() -- AstroNvim standard mappings, Cyrillic
