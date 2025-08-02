return {
	-- PlatformIO.
	{
		"anurag3301/nvim-platformio.lua",
		dependencies = {
			{ "akinsho/toggleterm.nvim" },
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "folke/which-key.nvim" },
		},
		lazy = false,
		init = function()
			require("platformio").setup({
				-- lsp = "clangd", --default: ccls, other option: clangd
				-- If you pick clangd, it also creates compile_commands.json
			})
		end,
		-- event = "BufRead",
	},
}
