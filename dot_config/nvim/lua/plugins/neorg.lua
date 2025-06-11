return {
	-- Note taking.
	{
		"nvim-neorg/neorg",
		lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
		version = "*", -- Pin Neorg to the latest stable release
		config = true,
		init = function()
			require("neorg").setup({
				load = {
					["core.concealer"] = {
						-- Configuration options go here
					},
					-- Your other modules...
				},
			})
		end,
	},
}
