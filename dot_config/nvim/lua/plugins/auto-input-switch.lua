if os.getenv "XDG_CURRENT_DESKTOP" == "GNOME" then
  return {
    {
      "amekusa/auto-input-switch.nvim",
      lazy = false,
      opts = {
        os_settings = {
          linux = {
            cmd_get = vim.fn.stdpath "config" .. "/gnome-kbd.sh", -- set the command that outputs the keyboard state
            cmd_set = vim.fn.stdpath "config" .. "/gnome-kbd.sh %s", -- set the command that changes the keyboard state
            -- normal_input = "us", -- Optional.
            lang_inputs = {
              Ru = "ru",
              Es = "es",
              Slavonic = "m17n:cu:kbd",
              Hellenic = "m17n:grc:mizuochi",
            },
          },
        },
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
