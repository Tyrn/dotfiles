-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
	"AstroNvim/astrocommunity",
	{ import = "astrocommunity.pack.lua" },
	{ import = "astrocommunity.pack.rust" },
	{ import = "astrocommunity.pack.python" },
	{ import = "astrocommunity.pack.kotlin" },
	{ import = "astrocommunity.pack.elixir-phoenix" },
	{ import = "astrocommunity.pack.json" },
	{ import = "astrocommunity.pack.elm" },
	{ import = "astrocommunity.pack.nix" },
	{ import = "astrocommunity.pack.haskell" },
	{ import = "astrocommunity.pack.typst" },
	-- import/override with your plugins folder
}
