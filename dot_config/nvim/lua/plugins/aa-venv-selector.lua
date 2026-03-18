if false then
  return {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      { "nvim-telescope/telescope.nvim", version = "*", dependencies = { "nvim-lua/plenary.nvim" } }, -- optional: you can also use fzf-lua, snacks, mini-pick instead.
    },
    ft = "python", -- Load when opening Python files
    -- keys = { { ",v", "<cmd>VenvSelect<cr>" } }, -- Open picker on keymap
    keys = {
      -- Keymap to open the selector
      { "<leader>LV", "<cmd>VenvSelect<cr>" },
    },
    opts = {
      options = {}, -- plugin-wide options
      search = {}, -- custom search definitions
    },
  }
else
  return {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    opts = {
      name = ".venv", -- Tell it to look for your uv environment
      auto_refresh = true,
    },
    keys = {
      -- Keymap to open the selector
      { "<leader>Lv", "<cmd>VenvSelect<cr>" },
    },
  }
end
