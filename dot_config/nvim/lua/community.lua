-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
	"AstroNvim/astrocommunity",
	{ import = "astrocommunity.recipes.neovide" },
	{ import = "astrocommunity.note-taking.neorg" },
	{ import = "astrocommunity.pack.lua" },
	{ import = "astrocommunity.pack.cmake" },
	{ import = "astrocommunity.pack.cpp" },
	{ import = "astrocommunity.pack.html-css" },
	{ import = "astrocommunity.pack.toml" },
	{ import = "astrocommunity.pack.yaml" },
	{ import = "astrocommunity.pack.json" },
	{ import = "astrocommunity.pack.typescript-all-in-one" },
	{ import = "astrocommunity.pack.rust" },
	{ import = "astrocommunity.pack.dart" },
	{ import = "astrocommunity.pack.python" },
	{ import = "astrocommunity.pack.elixir-phoenix" },
	{ import = "astrocommunity.pack.elm" },
	{ import = "astrocommunity.pack.nix" },
	{ import = "astrocommunity.pack.typst" },
	-- { import = "astrocommunity.pack.haskell" },  -- Commented out because the plugin won't work without Haskell up.
	-- { import = "astrocommunity.pack.kotlin" },
	-- import/override with your plugins folder
}
