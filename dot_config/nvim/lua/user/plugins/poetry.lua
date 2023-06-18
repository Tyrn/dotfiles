return {
  -- Python Poetry package manager.
  {
    'petobens/poet-v',
      lazy = false,
      init = function ()
        vim.g.poetv_executables = {'poetry'}
        vim.g.poetv_auto_activate = 0
        vim.g.poetv_set_environment = 1
        vim.g.poetv_statusline_symbol = 'П'
      end
  },
}

