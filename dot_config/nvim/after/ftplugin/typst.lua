-- Typst remapping
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_buf_set_keymap

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
