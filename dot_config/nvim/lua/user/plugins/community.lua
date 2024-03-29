return {
	-- Add the community repository of plugin specifications
	"AstroNvim/astrocommunity",
	-- example of imporing a plugin, comment out to use it or add your own
	-- available plugins can be found at https://github.com/AstroNvim/astrocommunity
	-- { import = "astrocommunity.colorscheme.catppuccin" },
	{ import = "astrocommunity.pack.lua" },
	{ import = "astrocommunity.pack.rust" },
	{ import = "astrocommunity.pack.python" },
	{ import = "astrocommunity.pack.kotlin" },
	{ import = "astrocommunity.pack.json" },
	{ import = "astrocommunity.pack.elm" },
	{ import = "astrocommunity.pack.nix" },
	{ import = "astrocommunity.pack.haskell" },
	{ import = "astrocommunity.pack.typst" },
}
