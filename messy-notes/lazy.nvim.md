# lazy.nvim plugin manager for Neovim

## AstroNvim details

**Short answer:**  
AstroNvim doesn’t change the Lazy.nvim spec format for most keys. What you’re looking at is just a normal Lazy spec placed in a `lua/plugins/*.lua` file. The main “translation” is:

- Wrap your spec(s) in `return { ... }` and put the file under `lua/plugins/`.
- Prefer `opts` (table or function) instead of `config = function() require(...).setup({...}) end`.
- Keys like `lazy`, `priority`, `dependencies`, `event`, `cmd`, etc. stay exactly the same.

AstroNvim just adds a few helpers (e.g. `opts` merging, AstroCore utilities).【turn3fetch0】【turn4fetch0】

Below is a step‑by‑step mapping and your specific example converted.

## 1. Where things go in AstroNvim

In AstroNvim, plugin specs are just Lazy specs stored in:

- `lua/plugins/` (common)
- or `lua/user/plugins/` in older setups

Each file returns a table of plugin specs, and Lazy automatically picks them up. The docs explicitly say you’re writing standard Lazy specs and just dropping them in `lua/plugins/`.【turn1fetch0】

Example file:

- `lua/plugins/my_plugins.lua`:
  ```lua
  return {
    { "neovim/nvim-lspconfig", opts = {} },
    { "catppuccin/nvim", name = "catppuccin", opts = { ... } },
  }
  ```

## 2. Direct key mapping: pure Lazy → AstroNvim style

Most keys are identical; AstroNvim just encourages using `opts` instead of `config` where possible. Here’s the conceptual mapping:

| Pure lazy.nvim (what you have)                        | AstroNvim style (what to write)                                                                                                                                                                                                                        |
| ----------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Top-level `return { 'Wansmer/langmapper.nvim', ... }` | Same, but in `lua/plugins/xxx.lua`. AstroNvim just loads it as a Lazy spec.【turn1fetch0】                                                                                                                                                             |
| `lazy = false`                                        | Keep `lazy = false`. (AstroNvim uses `lazy` the same way.)【turn3fetch1】                                                                                                                                                                              |
| `priority = 1`                                        | Keep `priority = 1`. (Only affects start plugins, same semantics.)【turn4fetch0】                                                                                                                                                                      |
| `dependencies = { ... }`                              | Keep `dependencies = { ... }`. Lazy merges them in AstroNvim too.【turn3fetch0】                                                                                                                                                                       |
| `event = { ... }`                                     | Keep `event = { ... }`.【turn3fetch1】                                                                                                                                                                                                                 |
| `cmd = { ... }`                                       | Keep `cmd = { ... }`.【turn3fetch1】                                                                                                                                                                                                                   |
| `keys = { ... }`                                      | Keep `keys = { ... }`.【turn3fetch1】                                                                                                                                                                                                                  |
| `enabled = false / function()`                        | Keep `enabled = false` or a function. Same behavior.【turn3fetch1】                                                                                                                                                                                    |
| `init = function() ... end`                           | Keep `init`. AstroNvim does not change this.【turn4fetch0】                                                                                                                                                                                            |
| `config = function() require('foo').setup({...}) end` | Prefer `opts = { ... }` if possible. If you really need custom logic, use `opts = function(_, opts) ... end` or `config = function(plugin, opts) ... end`. AstroNvim allows both and merges `opts` with previous values.【turn3fetch0】【turn4fetch0】 |
| `opts = { ... }`                                      | Keep as is; AstroNvim merges `opts` tables with existing specs using `vim.tbl_deep_extend`. You can also use `opts = function(plugin, opts) ... end` to mutate/extend.【turn3fetch0】                                                                  |

AstroNvim’s own docs say: “As plugin specs are loaded in by lazy.nvim this field (opts) (along with others like cmd, event, ft, keys, dependencies) is merged with previous settings that lazy.nvim has already setup.”【turn3fetch0】

## 3. Your specific example: langmapper.nvim

You gave this pure Lazy spec:

```lua
return {
  'Wansmer/langmapper.nvim',
  lazy = false,
  priority = 1, -- High priority is needed if you will use `autoremap()`
  config = function()
    require('langmapper').setup({--[[ your config ]]})
  end,
}
```

A direct, AstroNvim-style translation (recommended) is to move your configuration into `opts`, which Lazy (and AstroNvim) will automatically pass to the plugin’s setup:

In `lua/plugins/langmapper.lua`:

```lua
return {
  {
    "Wansmer/langmapper.nvim",
    lazy = false,
    priority = 1, -- same reason
    opts = {
      -- put your existing setup() options here
      -- for example:
      -- attach_to_buf = true,
      -- map = { ... },
    },
  },
}
```

If you really prefer keeping `config = function() ... end`, you can still do that, but it’s less idiomatic in Lazy/AstroNvim:

```lua
return {
  {
    "Wansmer/langmapper.nvim",
    lazy = false,
    priority = 1,
    config = function()
      require("langmapper").setup({
        -- your config
      })
    end,
  },
}
```

Both will work; AstroNvim doesn’t forbid `config`, but Lazy’s docs (which AstroNvim follows) recommend `opts` when possible.【turn4fetch0】

## 4. More complex examples: opts vs config

Pure lazy.nvim (more verbose):

```lua
return {
  "folke/todo-comments.nvim",
  lazy = false,
  config = function()
    require("todo-comments").setup({
      signs = true,
      keywords = {
        FIX = { icon = " ", color = "error" },
        TODO = { icon = " ", color = "info" },
      },
    })
  end,
}
```

AstroNvim style (preferred):

```lua
return {
  {
    "folke/todo-comments.nvim",
    lazy = false,
    opts = {
      signs = true,
      keywords = {
        FIX = { icon = " ", color = "error" },
        TODO = { icon = " ", color = "info" },
      },
    },
  },
}
```

### When you’d use a function for opts

If you need to compute something, require modules, or merge with existing opts (common when overriding AstroNvim core plugins), use `opts = function(plugin, opts) ... end`:

```lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if not opts.ensure_installed then
        opts.ensure_installed = {}
      end
      vim.list_extend(opts.ensure_installed, { "lua", "vim", "python" })
      return opts
    end,
  },
}
```

AstroNvim explicitly documents this pattern for overriding core plugins.【turn3fetch0】

## 5. Extending core plugin configs in AstroNvim

For AstroNvim’s core plugins that have additional logic in their `config`, you can call their default config function from your own `config`:

```lua
return {
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      -- run AstroNvim's default LuaSnip config
      require("astronvim.plugins.configs.luasnip")(plugin, opts)

      -- then add your custom behavior
      require("luasnip").filetype_extend("javascript", { "javascriptreact" })
    end,
  },
}
```

This is specific to AstroNvim’s core plugins and their `astronvim.plugins.configs.*` modules.【turn3fetch1】

## 6. Putting it all together: “translation recipe”

Given any pure Lazy.nvim spec:

- Put it in `lua/plugins/your_name.lua`.
- Keep the same outer `return { ... }` structure.
- Keep:
  - plugin string (or url/dir)
  - `name` if used
  - `lazy`, `priority`, `enabled`, `cond`
  - `dependencies`
  - `event`, `cmd`, `ft`, `keys`
  - `init`, `main`, `build`
- Convert configuration:
  - If it’s just `require('X').setup({...})`:
    - Replace `config = function() require('X').setup({...}) end`
    - With `opts = { ... }`.
  - If you need to call other functions or do more than setup:
    - Use `config = function(plugin, opts) ... end`.
    - For core plugins, optionally call `require("astronvim.plugins.configs.X")(plugin, opts)` inside.

Using your example:

- Pure Lazy:

  ```lua
  return {
    'Wansmer/langmapper.nvim',
    lazy = false,
    priority = 1,
    config = function()
      require('langmapper').setup({--[[ your config ]]})
    end,
  }
  ```

- AstroNvim translation (recommended):
  ```lua
  return {
    {
      "Wansmer/langmapper.nvim",
      lazy = false,
      priority = 1,
      opts = {
        -- your langmapper options go here
      },
    },
  }
  ```

That’s it: AstroNvim is basically Lazy plus a bit of opinionated structuring (`lua/plugins/`) and some convenience around `opts` merging.
