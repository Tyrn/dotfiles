-- (La)TeX remapping
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_buf_set_keymap

keymap(0, "n", "ѵ", "0", opts)
keymap(0, "n", "ѱ", "G", opts)
keymap(0, "n", ";", "$", opts) -- Russian dollar
keymap(0, "n", "Ñ", ":", opts) -- Spanish colon
keymap(0, "n", ".", "/", opts) -- Russian slash
keymap(0, "n", "-", "/", opts) -- Spanish slash
keymap(0, "i", "YY", "{\\slv{}}", opts)
keymap(0, "i", "НН", "{\\slv{}}", opts)
keymap(0, "i", "NN", "\\textbf{}", opts)
keymap(0, "i", "ТТ", "\\textbf{}", opts)
keymap(0, "i", "II", "\\emph{}", opts)
keymap(0, "i", "ШШ", "\\emph{}", opts)
keymap(0, "i", "OO", "{}", opts)
keymap(0, "i", "ЩЩ", "{}", opts)
keymap(0, "i", "PP", "~\textemdash~", opts)
keymap(0, "i", "ЗЗ", "~\\textemdash~", opts)
keymap(0, "i", "LL", "\\ldots{}", opts)
keymap(0, "i", "ДД", "\\ldots{}", opts)
keymap(0, "i", "HH", "---~", opts)
keymap(0, "i", "РР", "---~", opts)
keymap(0, "i", "HJ", "~---", opts)
keymap(0, "i", "РО", "~---", opts)
keymap(0, "i", "JJ", "~---~", opts)
keymap(0, "i", "ОО", "~---~", opts)
keymap(0, "i", "ББ", "<<", opts)
keymap(0, "i", "ЮЮ", ">>", opts)
keymap(0, "i", "БЬ", "«", opts)
keymap(0, "i", "ЮЬ", "»", opts)
keymap(0, "i", "ññ", "«", opts)
keymap(0, "i", "ÑÑ", "»", opts)

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
