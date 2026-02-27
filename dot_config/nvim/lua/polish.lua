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

-- Massive remappings
local scraps = require "scraps"

scraps.kinks() -- Assorted exotics, mostly Insert Mode
scraps.odds() -- AstroNvim standard mappings, Cyrillic
