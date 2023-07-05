return {
  -- VImTex configuration
  {
    "lervag/vimtex",
    init = function()
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_view_method = "general"
      vim.g.vimtex_view_general_viewer = "okular"
      vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
      -- vim.g.vimtex_view_general_options_latexmk = '--unique'
      vim.g.vimtex_compiler_progname = "nvr"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        background = 1,
        continuous = 1,
      }
    end,
    event = "BufRead",
  },
}
