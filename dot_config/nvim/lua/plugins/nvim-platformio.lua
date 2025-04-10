return {
	-- PlatformIO.
	{
		"anurag3301/nvim-platformio.lua",
		dependencies = {
			{ "akinsho/nvim-toggleterm.lua" },
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
		lazy = false,
		init = function() end,
		-- event = "BufRead",
	},
}
