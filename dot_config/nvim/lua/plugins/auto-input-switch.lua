if os.getenv("XDG_CURRENT_DESKTOP") == "GNOME" then
	return {
		-- Requires https://extensions.gnome.org/extension/6691/shyriiwook/
		--          (https://github.com/madhead/shyriiwook)
		{
			"amekusa/auto-input-switch.nvim",
			lazy = false,
			init = function()
				vim.fn.system(vim.fn.stdpath("config") .. "/gnome-kbd.sh us")
			end,
			opts = {
				-- Confine Normalize and Restore actions to ModeChanged event
				normalize = {
					on = false,
				},
				restore = {
					on = false,
					-- exclude_pattern = false, -- Disable exclusion
					-- exclude_pattern = [==[[-+0-9@#$%^&/\\¥=~<>(){}\[\];:`]]==], -- An option for Latin-based layouts like "es"
				},
				os_settings = {
					linux = {
						cmd_get = vim.fn.stdpath("config") .. "/gnome-kbd.sh", -- Set the command that outputs the keyboard state
						cmd_set = vim.fn.stdpath("config") .. "/gnome-kbd.sh %s", -- Set the command that changes the keyboard state
						normal_input = "us", -- Optional.
						lang_inputs = {
							Ru = "ru",
							Es = "es",
							Slavonic = "m17n:cu:kbd",
							Hellenic = "m17n:grc:mizuochi",
						},
					},
				},
				-- log = true,
			},
		},
	}
else
	return {
		{
			"amekusa/auto-input-switch.nvim",
			lazy = false,
			opts = {
				-- log = true,
			},
		},
	}
end
