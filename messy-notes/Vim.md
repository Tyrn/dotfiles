# Vim Editor

_Neovim, mostly_

## sudo

```
$ sudo -E nvim
```

## IntelliJ IDEA, IdeaVim plugin

`~/.ideavimrc`:

```
set clipboard+=unnamed
set ideajoin
set idearefactormode=keep
```

## Plugin functionality support

- [TSUpdate error, related to nvim-treesitter plugin](https://github.com/nvim-treesitter/nvim-treesitter/issues/913)

```
$ yay -S python-pynvim
$ yay -S neovim-remote
$ yay -S tree-sitter
$ yay -S tree-sitter-python-git
$ yay -S python-jedi
$ yay -S npm
```

## Clipboard

- Install `xclip` (or `xsel`)

- Add to `init.vim` to avoid printing `"+y` for the system clipboard:

```
set clipboard=unnamedplus
```

## AstroNvim 4.0

- [Re]install

```
$ rm -rf ~/.cache/nvim ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim
$ git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
$ rm -rf ~/.config/nvim/.git
```

If your user configuration is on `dotfiles`, install it right away:

```
chezmoi apply -v
```

If the [support packages](https://github.com/Tyrn/dotfiles/blob/main/messy-notes/Vim.md#plugin-functionality-support)
are already installed,

```
$ nvim
```

- [Astrcommunity](https://github.com/AstroNvim/astrocommunity) plugins,
  specifically [languages](https://github.com/AstroNvim/astrocommunity/tree/main/lua/astrocommunity/pack),
  `~/.config/nvim/lua/community.lua`

- AstroNvim mappings: `~/.config/nvim/lua/astronvim/mappings.lua`, **do not edit**
- User mappings, `~/.config/nvim/lua/user/mappings.lua`, example:

```
...
maps.n["<leader>lla"] = { ":VimtexContextMenu<CR>", desc = "VimTex context menu" }
maps.n["<leader>ддф"] = { "<cmd>VimtexContextMenu<cr>", desc = "VimTex context menu" }
...
-- Slavonic/Russian/Spanish special remapping
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "ѵ", "0", opts)
keymap("n", "ѱ", "G", opts)
keymap("n", ";", "$", opts) -- Russian dollar
keymap("n", "Ñ", ":", opts) -- Spanish colon
keymap("n", ".", "/", opts) -- Russian slash
keymap("n", "-", "/", opts) -- Spanish slash
...
```

- User mappings, `~/.config/nvim/after/ftplugin/tex.lua`, example:

```
-- (La)TeX remapping
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_buf_set_keymap

...
keymap(0, "i", "LL", "\\ldots{}", opts)
keymap(0, "i", "ДД", "\\ldots{}", opts)
...
-- Slavonic/Russian/Spanish special remapping
-- local keymap = vim.api.nvim_set_keymap
keymap(0, "n", "ѵ", "0", opts)
keymap(0, "n", "ѱ", "G", opts)
keymap(0, "n", ";", "$", opts) -- Russian dollar
keymap(0, "n", "Ñ", ":", opts) -- Spanish colon
keymap(0, "n", ".", "/", opts) -- Russian slash
keymap(0, "n", "-", "/", opts) -- Spanish slash
```

### VimTeX & Okular

- Okular Settings > Configure Okular... > Editor > Custom Text Editor ([neovim-remote installed](https://github.com/mhinz/neovim-remote))

```
nvr --remote-silent %f -c %l
```

- `~/.latexmkrc`

```
$pdf_mode = 1;
$pdflatex = 'xelatex -interaction=nonstopmode -synctex=1';
$pdf_previewer = 'okular --unique';
```

- `~/.config/nvim/lua/user/plugins/vimtex.lua`

```
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
        keys = { ... },
	},
}

```

- _Shift+Left Click_ (inverse search) with Okular is working only in _Browse_ mode.

### VimTeX & Zathura

- `~/.latexmkrc`

```
$pdf_mode = 1;
$pdflatex = 'xelatex -interaction=nonstopmode -synctex=1';
```

- `~/.config/nvim/lua/user/plugins/vimtex.lua`

```
return {
	-- VImTex configuration
	{
		"lervag/vimtex",
		lazy = false,
		init = function()
			vim.g.tex_flavor = "latex"
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_compiler_method = "latexmk"
			vim.g.vimtex_compiler_latexmk = {
				background = 1,
				continuous = 1,
			}
		end,
		event = "BufRead",
        keys = { ... },
	},
}

```

- _Ctrl+Left Click_ - inverse search

## Spell checking (legacy)

- `init.vim`:

```
set spelllang=ru_ru,en_us,es_es
nmap <leader>ss :set invspell<CR>
```

- `*.spl` files are found in `/.local/share/nvim/site/spell`; also

```
$ locate en.utf-8.spl
/usr/share/nvim/runtime/spell/en.utf-8.spl
```

## Sharing plugins with Vim (legacy)

- [Arch Wiki](https://wiki.archlinux.org/index.php/Neovim), [Color scheme, etc.](https://vi.stackexchange.com/questions/12794/how-to-share-config-between-vim-and-neovim)

## Python support (legacy)

[A Complete Guide for Installing and Setting up Neovim for Python Development](https://jdhao.github.io/2018/12/24/centos_nvim_install_use_guide_en/) (Cocless)

## VimTeX (legacy)

[Superfluous viewer instances](https://github.com/lervag/vimtex/issues/313)

[**Configuration issue**](https://github.com/lervag/vimtex/issues/1392)

## Misc (legacy)

- Install a [Nerd Font](https://www.nerdfonts.com/font-downloads) (_FiraMono Nerd Font_ will do); [howto](https://gist.github.com/matthewjberger/7dd7e079f282f8138a9dc3b045ebefa0)

- Ensure [vim-plug](https://github.com/junegunn/vim-plug) to be installed (Auto install may fail):

```
$ curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

- In case of errors on start:

```
:PlugInstall
```

- In case of errors on update:

```
:PlugClean
:PlugInstall
```

- Total cleanup:

```
$ rm -rf ~/.cache/nvim ~/.config/nvim/plugged ~/.local/share/nvim
```

- Sometimes useful:

```
:UpdateRemotePlugins
```

- Create backup folder:

```
$ mkdir ~/.local/share/nvim/backup
```

- In Neovim: `:checkhealth provider`
