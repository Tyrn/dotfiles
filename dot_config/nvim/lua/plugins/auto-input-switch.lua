if os.getenv "XDG_CURRENT_DESKTOP" == "GNOME" then
  return {
    -- Requires https://extensions.gnome.org/extension/6691/shyriiwook/
    --          (https://github.com/madhead/shyriiwook)
    {
      "amekusa/auto-input-switch.nvim",
      lazy = false,
      init = function() vim.fn.system(vim.fn.stdpath "config" .. "/gnome-kbd.sh us") end,
      opts = {
        -- Confine Normalize and Restore actions to ModeChanged event
        normalize = {
          on = false,
        },
        restore = {
          on = false,
        },
        os_settings = {
          linux = {
            cmd_get = vim.fn.stdpath "config" .. "/gnome-kbd.sh", -- set the command that outputs the keyboard state
            cmd_set = vim.fn.stdpath "config" .. "/gnome-kbd.sh %s", -- set the command that changes the keyboard state
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
