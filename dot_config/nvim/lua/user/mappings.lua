local utils = require "astronvim.utils"
local get_icon = utils.get_icon
local is_available = utils.is_available
local ui = require "astronvim.utils.ui"

local maps = { i = {}, n = {}, v = {}, t = {} }

local sections = {
  f = { desc = get_icon("Search", 1, true) .. "Find" },
  p = { desc = get_icon("Package", 1, true) .. "Packages" },
  l = { desc = get_icon("ActiveLSP", 1, true) .. "LSP" },
  u = { desc = get_icon("Window", 1, true) .. "UI/UX" },
  b = { desc = get_icon("Tab", 1, true) .. "Buffers" },
  bs = { desc = get_icon("Sort", 1, true) .. "Sort Buffers" },
  d = { desc = get_icon("Debugger", 1, true) .. "Debugger" },
  g = { desc = get_icon("Git", 1, true) .. "Git" },
  S = { desc = get_icon("Session", 1, true) .. "Session" },
  t = { desc = get_icon("Terminal", 1, true) .. "Terminal" },
}

--
-- Russian remapping, based on nvim/astronvim/mappings BEGIN
--

-- Normal --
-- Standard Operations
-- maps.n["j"] = { "v:count == 0 ? 'gj' : 'j'", expr = true, desc = "Move cursor down" }
-- maps.n["k"] = { "v:count == 0 ? 'gk' : 'k'", expr = true, desc = "Move cursor up" }
maps.n["<leader>ц"] = { "<cmd>w<cr>", desc = "Save" }
maps.n["<leader>й"] = { "<cmd>confirm q<cr>", desc = "Quit" }
maps.n["<leader>т"] = { "<cmd>enew<cr>", desc = "New File" }
maps.n["пч"] = { utils.system_open, desc = "Open the file under cursor with system app" }
maps.n["<C-ы>"] = { "<cmd>w!<cr>", desc = "Force write" }
maps.n["<C-й>"] = { "<cmd>q!<cr>", desc = "Force quit" }
-- maps.n["|"] = { "<cmd>vsplit<cr>", desc = "Vertical Split" }
-- maps.n["\\"] = { "<cmd>split<cr>", desc = "Horizontal Split" }

-- Plugin Manager
maps.n["<leader>з"] = sections.p
maps.n["<leader>зш"] = { function() require("lazy").install() end, desc = "Plugins Install" }
maps.n["<leader>зы"] = { function() require("lazy").home() end, desc = "Plugins Status" }
maps.n["<leader>зЫ"] = { function() require("lazy").sync() end, desc = "Plugins Sync" }
maps.n["<leader>зг"] = { function() require("lazy").check() end, desc = "Plugins Check Updates" }
maps.n["<leader>зГ"] = { function() require("lazy").update() end, desc = "Plugins Update" }

-- AstroNvim
maps.n["<leader>зф"] = { "<cmd>AstroUpdatePackages<cr>", desc = "Update Plugins and Mason Packages" }
maps.n["<leader>зФ"] = { "<cmd>AstroUpdate<cr>", desc = "AstroNvim Update" }
maps.n["<leader>зм"] = { "<cmd>AstroVersion<cr>", desc = "AstroNvim Version" }
maps.n["<leader>зд"] = { "<cmd>AstroChangelog<cr>", desc = "AstroNvim Changelog" }

-- Manage Buffers
maps.n["<leader>с"] = { function() require("astronvim.utils.buffer").close() end, desc = "Close buffer" }
maps.n["<leader>С"] = { function() require("astronvim.utils.buffer").close(0, true) end, desc = "Force close buffer" }
maps.n["]и"] =
  { function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end, desc = "Next buffer" }
maps.n["[и"] = {
  function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
  desc = "Previous buffer",
}
maps.n[">и"] = {
  function() require("astronvim.utils.buffer").move(vim.v.count > 0 and vim.v.count or 1) end,
  desc = "Move buffer tab right",
}
maps.n["<и"] = {
  function() require("astronvim.utils.buffer").move(-(vim.v.count > 0 and vim.v.count or 1)) end,
  desc = "Move buffer tab left",
}

maps.n["<leader>и"] = sections.b
maps.n["<leader>ис"] =
  { function() require("astronvim.utils.buffer").close_all(true) end, desc = "Close all buffers except current" }
maps.n["<leader>иС"] = { function() require("astronvim.utils.buffer").close_all() end, desc = "Close all buffers" }
maps.n["<leader>ии"] = {
  function()
    require("astronvim.utils.status.heirline").buffer_picker(function(bufnr) vim.api.nvim_win_set_buf(0, bufnr) end)
  end,
  desc = "Select buffer from tabline",
}
maps.n["<leader>ив"] = {
  function()
    require("astronvim.utils.status.heirline").buffer_picker(
      function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
    )
  end,
  desc = "Close buffer from tabline",
}
maps.n["<leader>ид"] =
  { function() require("astronvim.utils.buffer").close_left() end, desc = "Close all buffers to the left" }
maps.n["<leader>ик"] =
  { function() require("astronvim.utils.buffer").close_right() end, desc = "Close all buffers to the right" }
maps.n["<leader>иы"] = sections.bs
maps.n["<leader>иыу"] = { function() require("astronvim.utils.buffer").sort "extension" end, desc = "By extension" }
maps.n["<leader>иык"] =
  { function() require("astronvim.utils.buffer").sort "unique_path" end, desc = "By relative path" }
maps.n["<leader>иыз"] = { function() require("astronvim.utils.buffer").sort "full_path" end, desc = "By full path" }
maps.n["<leader>иыш"] = { function() require("astronvim.utils.buffer").sort "bufnr" end, desc = "By buffer number" }
maps.n["<leader>иыь"] =
  { function() require("astronvim.utils.buffer").sort "modified" end, desc = "By modification" }
maps.n["<leader>и\\"] = {
  function()
    require("astronvim.utils.status.heirline").buffer_picker(function(bufnr)
      vim.cmd.split()
      vim.api.nvim_win_set_buf(0, bufnr)
    end)
  end,
  desc = "Horizontal split buffer from tabline",
}
maps.n["<leader>и|"] = {
  function()
    require("astronvim.utils.status.heirline").buffer_picker(function(bufnr)
      vim.cmd.vsplit()
      vim.api.nvim_win_set_buf(0, bufnr)
    end)
  end,
  desc = "Vertical split buffer from tabline",
}

-- Navigate tabs
maps.n["]е"] = { function() vim.cmd.tabnext() end, desc = "Next tab" }
maps.n["[е"] = { function() vim.cmd.tabprevious() end, desc = "Previous tab" }

-- Alpha
if is_available "alpha-nvim" then
  maps.n["<leader>р"] = {
    function()
      local wins = vim.api.nvim_tabpage_list_wins(0)
      if #wins > 1 and vim.api.nvim_get_option_value("filetype", { win = wins[1] }) == "neo-tree" then
        vim.fn.win_gotoid(wins[2]) -- go to non-neo-tree window to toggle alpha
      end
      require("alpha").start(false, require("alpha").default_config)
    end,
    desc = "Home Screen",
  }
end

-- -- Comment
-- if is_available "Comment.nvim" then
--   maps.n["<leader>/"] = {
--     function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
--     desc = "Toggle comment line",
--   }
--   maps.v["<leader>/"] = {
--     "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
--     desc = "Toggle comment for selection",
--   }
-- end

-- GitSigns
if is_available "gitsigns.nvim" then
  maps.n["<leader>п"] = sections.g
  maps.n["]п"] = { function() require("gitsigns").next_hunk() end, desc = "Next Git hunk" }
  maps.n["[п"] = { function() require("gitsigns").prev_hunk() end, desc = "Previous Git hunk" }
  maps.n["<leader>пд"] = { function() require("gitsigns").blame_line() end, desc = "View Git blame" }
  maps.n["<leader>пД"] =
    { function() require("gitsigns").blame_line { full = true } end, desc = "View full Git blame" }
  maps.n["<leader>пз"] = { function() require("gitsigns").preview_hunk() end, desc = "Preview Git hunk" }
  maps.n["<leader>пр"] = { function() require("gitsigns").reset_hunk() end, desc = "Reset Git hunk" }
  maps.n["<leader>пк"] = { function() require("gitsigns").reset_buffer() end, desc = "Reset Git buffer" }
  maps.n["<leader>пы"] = { function() require("gitsigns").stage_hunk() end, desc = "Stage Git hunk" }
  maps.n["<leader>пЫ"] = { function() require("gitsigns").stage_buffer() end, desc = "Stage Git buffer" }
  maps.n["<leader>пг"] = { function() require("gitsigns").undo_stage_hunk() end, desc = "Unstage Git hunk" }
  maps.n["<leader>пв"] = { function() require("gitsigns").diffthis() end, desc = "View Git diff" }
end

-- NeoTree
if is_available "neo-tree.nvim" then
  maps.n["<leader>у"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" }
  maps.n["<leader>щ"] = {
    function()
      if vim.bo.filetype == "neo-tree" then
        vim.cmd.wincmd "p"
      else
        vim.cmd.Neotree "focus"
      end
    end,
    desc = "Toggle Explorer Focus",
  }
end

-- Session Manager
if is_available "neovim-session-manager" then
  maps.n["<leader>Ы"] = sections.S
  maps.n["<leader>Ыд"] = { "<cmd>SessionManager! load_last_session<cr>", desc = "Load last session" }
  maps.n["<leader>Ыы"] = { "<cmd>SessionManager! save_current_session<cr>", desc = "Save this session" }
  maps.n["<leader>Ыв"] = { "<cmd>SessionManager! delete_session<cr>", desc = "Delete session" }
  maps.n["<leader>Ыа"] = { "<cmd>SessionManager! load_session<cr>", desc = "Search sessions" }
  maps.n["<leader>Ы."] =
    { "<cmd>SessionManager! load_current_dir_session<cr>", desc = "Load current directory session" }
end
if is_available "resession.nvim" then
  maps.n["<leader>Ы"] = sections.S
  maps.n["<leader>Ыд"] = { function() require("resession").load "Last Session" end, desc = "Load last session" }
  maps.n["<leader>Ыы"] = { function() require("resession").save() end, desc = "Save this session" }
  maps.n["<leader>Ые"] = { function() require("resession").save_tab() end, desc = "Save this tab's session" }
  maps.n["<leader>Ыв"] = { function() require("resession").delete() end, desc = "Delete a session" }
  maps.n["<leader>Ыа"] = { function() require("resession").load() end, desc = "Load a session" }
  maps.n["<leader>Ы."] = {
    function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession" }) end,
    desc = "Load current directory session",
  }
end

-- Package Manager
if is_available "mason.nvim" then
  maps.n["<leader>зь"] = { "<cmd>Mason<cr>", desc = "Mason Installer" }
  maps.n["<leader>зЬ"] = { "<cmd>MasonUpdateAll<cr>", desc = "Mason Update" }
end

-- Smart Splits
if is_available "smart-splits.nvim" then
  maps.n["<C-р>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" }
  maps.n["<C-о>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" }
  maps.n["<C-л>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" }
  maps.n["<C-д>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" }
  --   maps.n["<C-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" }
  --   maps.n["<C-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" }
  --   maps.n["<C-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" }
  --   maps.n["<C-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" }
else
  maps.n["<C-р>"] = { "<C-w>h", desc = "Move to left split" }
  maps.n["<C-о>"] = { "<C-w>j", desc = "Move to below split" }
  maps.n["<C-л>"] = { "<C-w>k", desc = "Move to above split" }
  maps.n["<C-д>"] = { "<C-w>l", desc = "Move to right split" }
  --   maps.n["<C-Up>"] = { "<cmd>resize -2<CR>", desc = "Resize split up" }
  --   maps.n["<C-Down>"] = { "<cmd>resize +2<CR>", desc = "Resize split down" }
  --   maps.n["<C-Left>"] = { "<cmd>vertical resize -2<CR>", desc = "Resize split left" }
  --   maps.n["<C-Right>"] = { "<cmd>vertical resize +2<CR>", desc = "Resize split right" }
end

-- SymbolsOutline
if is_available "aerial.nvim" then
  maps.n["<leader>д"] = sections.l
  maps.n["<leader>дЫ"] = { function() require("aerial").toggle() end, desc = "Symbols outline" }
end

-- Telescope
if is_available "telescope.nvim" then
  maps.n["<leader>а"] = sections.f
  maps.n["<leader>п"] = sections.g
  maps.n["<leader>пи"] = { function() require("telescope.builtin").git_branches() end, desc = "Git branches" }
  maps.n["<leader>пс"] = { function() require("telescope.builtin").git_commits() end, desc = "Git commits" }
  maps.n["<leader>пе"] = { function() require("telescope.builtin").git_status() end, desc = "Git status" }
  maps.n["<leader>а<CR>"] = { function() require("telescope.builtin").resume() end, desc = "Resume previous search" }
  maps.n["<leader>аэ"] = { function() require("telescope.builtin").marks() end, desc = "Find marks" }
  maps.n["<leader>аф"] = {
    function()
      local cwd = vim.fn.stdpath "config" .. "/.."
      local search_dirs = {}
      for _, dir in ipairs(astronvim.supported_configs) do -- search all supported config locations
        if dir == astronvim.install.home then dir = dir .. "/lua/user" end -- don't search the astronvim core files
        if vim.fn.isdirectory(dir) == 1 then table.insert(search_dirs, dir) end -- add directory to search if exists
      end
      if vim.tbl_isempty(search_dirs) then -- if no config folders found, show warning
        utils.notify("No user configuration files found", vim.log.levels.WARN)
      else
        if #search_dirs == 1 then cwd = search_dirs[1] end -- if only one directory, focus cwd
        require("telescope.builtin").find_files {
          prompt_title = "Config Files",
          search_dirs = search_dirs,
          cwd = cwd,
        } -- call telescope
      end
    end,
    desc = "Find AstroNvim config files",
  }
  maps.n["<leader>аи"] = { function() require("telescope.builtin").buffers() end, desc = "Find buffers" }
  maps.n["<leader>ас"] =
    { function() require("telescope.builtin").grep_string() end, desc = "Find for word under cursor" }
  maps.n["<leader>аС"] = { function() require("telescope.builtin").commands() end, desc = "Find commands" }
  maps.n["<leader>аа"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" }
  maps.n["<leader>аА"] = {
    function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
    desc = "Find all files",
  }
  maps.n["<leader>ар"] = { function() require("telescope.builtin").help_tags() end, desc = "Find help" }
  maps.n["<leader>ал"] = { function() require("telescope.builtin").keymaps() end, desc = "Find keymaps" }
  maps.n["<leader>аь"] = { function() require("telescope.builtin").man_pages() end, desc = "Find man" }
  if is_available "nvim-notify" then
    maps.n["<leader>ат"] =
      { function() require("telescope").extensions.notify.notify() end, desc = "Find notifications" }
  end
  maps.n["<leader>ащ"] = { function() require("telescope.builtin").oldfiles() end, desc = "Find history" }
  maps.n["<leader>ак"] = { function() require("telescope.builtin").registers() end, desc = "Find registers" }
  maps.n["<leader>ае"] =
    { function() require("telescope.builtin").colorscheme { enable_preview = true } end, desc = "Find themes" }
  maps.n["<leader>ац"] = { function() require("telescope.builtin").live_grep() end, desc = "Find words" }
  maps.n["<leader>аЦ"] = {
    function()
      require("telescope.builtin").live_grep {
        additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
      }
    end,
    desc = "Find words in all files",
  }
  maps.n["<leader>д"] = sections.l
  maps.n["<leader>ды"] = {
    function()
      local aerial_avail, _ = pcall(require, "aerial")
      if aerial_avail then
        require("telescope").extensions.aerial.aerial()
      else
        require("telescope.builtin").lsp_document_symbols()
      end
    end,
    desc = "Search symbols",
  }
end

-- -- Terminal
-- if is_available "toggleterm.nvim" then
--   maps.n["<leader>t"] = sections.t
--   if vim.fn.executable "lazygit" == 1 then
--     maps.n["<leader>g"] = sections.g
--     maps.n["<leader>gg"] = { function() utils.toggle_term_cmd "lazygit" end, desc = "ToggleTerm lazygit" }
--     maps.n["<leader>tl"] = { function() utils.toggle_term_cmd "lazygit" end, desc = "ToggleTerm lazygit" }
--   end
--   if vim.fn.executable "node" == 1 then
--     maps.n["<leader>tn"] = { function() utils.toggle_term_cmd "node" end, desc = "ToggleTerm node" }
--   end
--   if vim.fn.executable "gdu" == 1 then
--     maps.n["<leader>tu"] = { function() utils.toggle_term_cmd "gdu" end, desc = "ToggleTerm gdu" }
--   end
--   if vim.fn.executable "btm" == 1 then
--     maps.n["<leader>tt"] = { function() utils.toggle_term_cmd "btm" end, desc = "ToggleTerm btm" }
--   end
--   local python = vim.fn.executable "python" == 1 and "python" or vim.fn.executable "python3" == 1 and "python3"
--   if python then maps.n["<leader>tp"] = { function() utils.toggle_term_cmd(python) end, desc = "ToggleTerm python" } end
--   maps.n["<leader>tf"] = { "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float" }
--   maps.n["<leader>th"] = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "ToggleTerm horizontal split" }
--   maps.n["<leader>tv"] = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "ToggleTerm vertical split" }
--   maps.n["<F7>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" }
--   maps.t["<F7>"] = maps.n["<F7>"]
--   maps.n["<C-'>"] = maps.n["<F7>"] -- requires terminal that supports binding <C-'>
--   maps.t["<C-'>"] = maps.n["<F7>"] -- requires terminal that supports binding <C-'>
-- end
--
-- if is_available "nvim-dap" then
--   maps.n["<leader>d"] = sections.d
--   maps.v["<leader>d"] = sections.d
--   -- modified function keys found with `showkey -a` in the terminal to get key code
--   -- run `nvim -V3log +quit` and search through the "Terminal info" in the `log` file for the correct keyname
--   maps.n["<F5>"] = { function() require("dap").continue() end, desc = "Debugger: Start" }
--   maps.n["<F17>"] = { function() require("dap").terminate() end, desc = "Debugger: Stop" } -- Shift+F5
--   maps.n["<F21>"] = {
--     function()
--       vim.ui.input({ prompt = "Condition: " }, function(condition)
--         if condition then require("dap").set_breakpoint(condition) end
--       end)
--     end,
--     desc = "Debugger: Conditional Breakpoint",
--   }
--   maps.n["<F29>"] = { function() require("dap").restart_frame() end, desc = "Debugger: Restart" } -- Control+F5
--   maps.n["<F6>"] = { function() require("dap").pause() end, desc = "Debugger: Pause" }
--   maps.n["<F9>"] = { function() require("dap").toggle_breakpoint() end, desc = "Debugger: Toggle Breakpoint" }
--   maps.n["<F10>"] = { function() require("dap").step_over() end, desc = "Debugger: Step Over" }
--   maps.n["<F11>"] = { function() require("dap").step_into() end, desc = "Debugger: Step Into" }
--   maps.n["<F23>"] = { function() require("dap").step_out() end, desc = "Debugger: Step Out" } -- Shift+F11
--   maps.n["<leader>db"] = { function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint (F9)" }
--   maps.n["<leader>dB"] = { function() require("dap").clear_breakpoints() end, desc = "Clear Breakpoints" }
--   maps.n["<leader>dc"] = { function() require("dap").continue() end, desc = "Start/Continue (F5)" }
--   maps.n["<leader>dC"] = {
--     function()
--       vim.ui.input({ prompt = "Condition: " }, function(condition)
--         if condition then require("dap").set_breakpoint(condition) end
--       end)
--     end,
--     desc = "Conditional Breakpoint (S-F9)",
--   }
--   maps.n["<leader>di"] = { function() require("dap").step_into() end, desc = "Step Into (F11)" }
--   maps.n["<leader>do"] = { function() require("dap").step_over() end, desc = "Step Over (F10)" }
--   maps.n["<leader>dO"] = { function() require("dap").step_out() end, desc = "Step Out (S-F11)" }
--   maps.n["<leader>dq"] = { function() require("dap").close() end, desc = "Close Session" }
--   maps.n["<leader>dQ"] = { function() require("dap").terminate() end, desc = "Terminate Session (S-F5)" }
--   maps.n["<leader>dp"] = { function() require("dap").pause() end, desc = "Pause (F6)" }
--   maps.n["<leader>dr"] = { function() require("dap").restart_frame() end, desc = "Restart (C-F5)" }
--   maps.n["<leader>dR"] = { function() require("dap").repl.toggle() end, desc = "Toggle REPL" }
--   maps.n["<leader>ds"] = { function() require("dap").run_to_cursor() end, desc = "Run To Cursor" }
--
--   if is_available "nvim-dap-ui" then
--     maps.n["<leader>dE"] = {
--       function()
--         vim.ui.input({ prompt = "Expression: " }, function(expr)
--           if expr then require("dapui").eval(expr) end
--         end)
--       end,
--       desc = "Evaluate Input",
--     }
--     maps.v["<leader>dE"] = { function() require("dapui").eval() end, desc = "Evaluate Input" }
--     maps.n["<leader>du"] = { function() require("dapui").toggle() end, desc = "Toggle Debugger UI" }
--     maps.n["<leader>dh"] = { function() require("dap.ui.widgets").hover() end, desc = "Debugger Hover" }
--   end
-- end
--
-- -- Improved Code Folding
-- if is_available "nvim-ufo" then
--   maps.n["zR"] = { function() require("ufo").openAllFolds() end, desc = "Open all folds" }
--   maps.n["zM"] = { function() require("ufo").closeAllFolds() end, desc = "Close all folds" }
--   maps.n["zr"] = { function() require("ufo").openFoldsExceptKinds() end, desc = "Fold less" }
--   maps.n["zm"] = { function() require("ufo").closeFoldsWith() end, desc = "Fold more" }
--   maps.n["zp"] = { function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "Peek fold" }
-- end
--
-- -- Stay in indent mode
-- maps.v["<S-Tab>"] = { "<gv", desc = "Unindent line" }
-- maps.v["<Tab>"] = { ">gv", desc = "Indent line" }
--
-- -- Improved Terminal Navigation
-- maps.t["<C-h>"] = { "<cmd>wincmd h<cr>", desc = "Terminal left window navigation" }
-- maps.t["<C-j>"] = { "<cmd>wincmd j<cr>", desc = "Terminal down window navigation" }
-- maps.t["<C-k>"] = { "<cmd>wincmd k<cr>", desc = "Terminal up window navigation" }
-- maps.t["<C-l>"] = { "<cmd>wincmd l<cr>", desc = "Terminal right window navigation" }
--
maps.n["<leader>г"] = sections.u
-- Custom menu for modification of the user experience
if is_available "nvim-autopairs" then maps.n["<leader>гф"] = { ui.toggle_autopairs, desc = "Toggle autopairs" } end
maps.n["<leader>ги"] = { ui.toggle_background, desc = "Toggle background" }
if is_available "nvim-cmp" then maps.n["<leader>гс"] = { ui.toggle_cmp, desc = "Toggle autocompletion" } end
if is_available "nvim-colorizer.lua" then
  maps.n["<leader>гС"] = { "<cmd>ColorizerToggle<cr>", desc = "Toggle color highlight" }
end
maps.n["<leader>гв"] = { ui.toggle_diagnostics, desc = "Toggle diagnostics" }
maps.n["<leader>гп"] = { ui.toggle_signcolumn, desc = "Toggle signcolumn" }
maps.n["<leader>гш"] = { ui.set_indent, desc = "Change indent setting" }
maps.n["<leader>гд"] = { ui.toggle_statusline, desc = "Toggle statusline" }
maps.n["<leader>гД"] = { ui.toggle_codelens, desc = "Toggle CodeLens" }
maps.n["<leader>гт"] = { ui.change_number, desc = "Change line numbering" }
maps.n["<leader>гТ"] = { ui.toggle_ui_notifications, desc = "Toggle UI notifications" }
maps.n["<leader>гз"] = { ui.toggle_paste, desc = "Toggle paste mode" }
maps.n["<leader>гы"] = { ui.toggle_spell, desc = "Toggle spellcheck" }
maps.n["<leader>гЫ"] = { ui.toggle_conceal, desc = "Toggle conceal" }
maps.n["<leader>ге"] = { ui.toggle_tabline, desc = "Toggle tabline" }
maps.n["<leader>гг"] = { ui.toggle_url_match, desc = "Toggle URL highlight" }
maps.n["<leader>гц"] = { ui.toggle_wrap, desc = "Toggle wrap" }
maps.n["<leader>гн"] = { ui.toggle_syntax, desc = "Toggle syntax highlight" }
maps.n["<leader>гр"] = { ui.toggle_foldcolumn, desc = "Toggle foldcolumn" }

-- utils.set_mappings(astronvim.user_opts("mappings", maps))

--
-- Russian remapping, based on nvim/astronvim/mappings END
--

-- Python Poetry
maps.n["<leader>poa"] = { ":PoetvActivate<CR>", desc = "Poetry activate" }
maps.n["<leader>pod"] = { ":PoetvDeactivate<CR>", desc = "Poetry deactivate" }

-- Vimtex mapping
maps.n["<leader>lli"] = { ":VimtexInfo<CR>", desc = "VimTex current project info" }
maps.n["<leader>ддш"] = { ":VimtexInfo<CR>", desc = "VimTex current project info" }
maps.n["<leader>llI"] = { ":VimtexInfo!<CR>", desc = "VimTex current project info" }
maps.n["<leader>ддШ"] = { ":VimtexInfo!<CR>", desc = "VimTex current project info" }
maps.n["<leader>llt"] = { ":VimtexTocOpen<CR>", desc = "VimTex open table of contents" }
maps.n["<leader>дде"] = { ":VimtexTocOpen<CR>", desc = "VimTex open table of contents" }
maps.n["<leader>llT"] = { ":VimtexTocToggle<CR>", desc = "VimTex toggle table of contents" }
maps.n["<leader>ддЕ"] = { ":VimtexTocToggle<CR>", desc = "VimTex toggle table of contents" }
maps.n["<leader>llq"] = { ":VimtexLog<CR>", desc = "VimTex log" }
maps.n["<leader>ддй"] = { ":VimtexLog<CR>", desc = "VimTex log" }
maps.n["<leader>llv"] = { ":VimtexView<CR>", desc = "VimTex view pdf (forward search)" }
maps.n["<leader>ддм"] = { ":VimtexView<CR>", desc = "VimTex view pdf (forward search)" }
maps.n["<leader>llr"] = { ":VimtexRSearch<CR>", desc = "VimTex VimtexRSearch?" }
maps.n["<leader>ддк"] = { ":VimtexRSearch<CR>", desc = "VimTex VimtexRSearch?" }
maps.n["<leader>lll"] = { ":VimtexCompile<CR>", desc = "VimTex compile" }
maps.n["<leader>ддд"] = { ":VimtexCompile<CR>", desc = "VimTex compile" }
maps.n["<leader>llL"] = { ":VimtexCompileSelected<CR>", desc = "VimTex compile the selected part" }
maps.n["<leader>ддД"] = { ":VimtexCompileSelected<CR>", desc = "VimTex compile the selected part" }
maps.n["<leader>llk"] = { ":VimtexStop<CR>", desc = "VimTex stop compilation for the current project" }
maps.n["<leader>ддл"] = { ":VimtexStop<CR>", desc = "VimTex stop compilation for the current project" }
maps.n["<leader>llK"] = { ":VimtexStopAll<CR>", desc = "VimTex stop compilation for all projects" }
maps.n["<leader>ддЛ"] = { ":VimtexStopAll<CR>", desc = "VimTex stop compilation for all projects" }
maps.n["<leader>lle"] = { ":VimtexErrors<CR>", desc = "VimTex open quick fix window (err/warn)" }
maps.n["<leader>дду"] = { ":VimtexErrors<CR>", desc = "VimTex open quick fix window (err/warn)" }
maps.n["<leader>llo"] = { ":VimtexCompileOutput<CR>", desc = "VimTex open file where compiler output is redirected" }
maps.n["<leader>ддщ"] = { ":VimtexCompileOutput<CR>", desc = "VimTex open file where compiler output is redirected" }
maps.n["<leader>llg"] = { ":VimtexStatus<CR>", desc = "VimTex show compilation status for the current project" }
maps.n["<leader>ддп"] = { ":VimtexStatus<CR>", desc = "VimTex show compilation status for the current project" }
maps.n["<leader>llG"] = { ":VimtexStatus!<CR>", desc = "VimTex show compilation status for all projects" }
maps.n["<leader>ддП"] = { ":VimtexStatus!<CR>", desc = "VimTex show compilation status for all projects" }
maps.n["<leader>llc"] = { ":VimtexClean<CR>", desc = "VimTex clean auxiliary files" }
maps.n["<leader>ддс"] = { ":VimtexClean<CR>", desc = "VimTex clean auxiliary files" }
maps.n["<leader>llC"] = { ":VimtexClean!<CR>", desc = "VimTex clean auxiliary and output files" }
maps.n["<leader>ддС"] = { ":VimtexClean!<CR>", desc = "VimTex clean auxiliary and output files" }
maps.n["<leader>llm"] = { ":VimtexImapsList<CR>", desc = "VimTex show imaps list" }
maps.n["<leader>ддь"] = { ":VimtexImapsList<CR>", desc = "VimTex show imaps list" }
maps.n["<leader>llx"] = { ":VimtexReload<CR>", desc = "VimTex reload scripts" }
maps.n["<leader>ддч"] = { ":VimtexReload<CR>", desc = "VimTex reload scripts" }
maps.n["<leader>llX"] = { ":VimtexReloadState<CR>", desc = "VimTex reload the state of the current buffer" }
maps.n["<leader>ддЧ"] = { ":VimtexReloadState<CR>", desc = "VimTex reload the state of the current buffer" }
maps.n["<leader>lls"] = { ":VimtexToggleMain<CR>", desc = "VimTex toggle main or current file as a target" }
maps.n["<leader>дды"] = { ":VimtexToggleMain<CR>", desc = "VimTex toggle main or current file as a target" }

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

-- Template:
--
-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  n = maps.n,
  -- -- first key is the mode
  -- n = {
  --   -- second key is the lefthand side of the map
  --   -- mappings seen under group name "Buffer"
  --   ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
  --   ["<leader>bD"] = {
  --     function()
  --       require("astronvim.utils.status").heirline.buffer_picker(function(bufnr) require("astronvim.utils.buffer").close(bufnr) end)
  --     end,
  --     desc = "Pick to close",
  --   },
  --   -- tables with the `name` key will be registered with which-key if it's installed
  --   -- this is useful for naming menus
  --   ["<leader>b"] = { name = "Buffers" },
  --   -- quick save
  --   -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  -- },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
