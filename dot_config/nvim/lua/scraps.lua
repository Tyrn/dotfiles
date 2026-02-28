-- Manual remappings for non-English layouts,
-- mostly Cyrillic, with a touch of Spanish.
local scraps = {}

local opts = { noremap = true, silent = true }
local lops = { remap = true, silent = true }

-- ⮟⮟⮟ Weird characters for Insert Mode ⮟⮟⮟

-- Insert Mode prefixes
local en_lp = "DF"
local en_rp = "KJ"
local ru_lp = "ВА"
local ru_rp = "ЛО"

-- Lambda for everybody
local lambda = "λ"

local function vks_l(symbol, en_key, ru_key)
  vim.keymap.set("i", en_lp .. en_key, symbol, opts)
  vim.keymap.set("i", ru_lp .. ru_key, symbol, opts)
end

local function vks_r(symbol, en_key, ru_key)
  vim.keymap.set("i", en_rp .. en_key, symbol, opts)
  vim.keymap.set("i", ru_rp .. ru_key, symbol, opts)
end

-- Makes Insert Mode reacher :)
function scraps.kinks()
  vim.keymap.set("i", en_rp .. ";", lambda, opts)
  vim.keymap.set("i", ru_rp .. "ж", lambda, opts)
  vim.keymap.set("i", en_rp .. "ñ", lambda, opts)

  vks_l("ᛞ", "s", "ы") -- Runic Super/Meta for everybody
  vks_l("ᛅ", "a", "ф") -- Runic Alt
  vks_l("⌃", "c", "с") -- Ctrl
  vks_l("ᛏ", "f", "а") -- Runic Shift
  vks_l("␣", "e", "у") -- Open Box Space
  vks_l("⮐", "r", "к") -- Enter
  vks_l("⇆", "t", "е") -- Tab
  vks_l("⎋", "q", "й") -- Escape
  vks_l("␥", "d", "в") -- Delete
  vks_l("⬞", "g", "п") -- Separator
  vks_l("ᛟ", "v", "м") -- Runic Leader
  vks_l("☉", "w", "ц") -- Mouse Wheel

  vks_r("⮜", "h", "р") -- Left arrow
  vks_r("⮟", "j", "о") -- Down arrow
  vks_r("⮝", "k", "л") -- Up arrow
  vks_r("⮞", "l", "д") -- Right arrow
  vks_r("⥾", "y", "н") -- Home
  vks_r("⤥", "u", "г") -- Page Down
  vks_r("⤣", "i", "ш") -- Page Up
  vks_r("⥿", "o", "щ") -- End
  vks_r("⌫", "n", "т") -- Backspace
  vks_r("ᛝ", "m", "ь") -- Runic Local Leader
  vks_r("ˋ", "'", "э") -- Non-toxic backtick
  vks_r("⎙", "p", "з") -- Print Screen

  -- ⮝⮝⮝ Weird characters for Insert Mode ⮝⮝⮝

  -- <C-w> selection
  vim.keymap.set("n", "<leader>Lo", "<C-w>o", opts)
  vim.keymap.set("n", "<leader>Ls", "<C-w>s", opts)
  vim.keymap.set("n", "<leader>Lv", "<C-w>v", opts)
  vim.keymap.set("n", "<leader>Lc", "<C-w>c", opts)
  vim.keymap.set("n", "<leader>Lw", "<C-w>w", opts)
end

-- Makes AstroNvim standard mappings usable
function scraps.odds()
  vim.keymap.set("n", "<leader>Дщ", "<C-w>o", opts)
  vim.keymap.set("n", "<leader>Ды", "<C-w>s", opts)
  vim.keymap.set("n", "<leader>Дм", "<C-w>v", opts)
  vim.keymap.set("n", "<leader>Дс", "<C-w>c", opts)
  vim.keymap.set("n", "<leader>Дц", "<C-w>w", opts)

  -- Slavonic/Russian/Spanish special remapping
  -- local keymap = vim.api.nvim_set_keymap
  vim.keymap.set("n", "ѵ", "0", opts)
  vim.keymap.set("n", "ѱ", "G", opts)
  -- vim.keymap.set("n", ";", "$", opts) -- Russian dollar
  -- Spanish colon
  vim.keymap.set("n", "Ñ", function() vim.fn.feedkeys(":", "it") end, { desc = "Ex Mode (:)" })
  -- Spanish slash
  vim.keymap.set("n", "-", function() vim.fn.feedkeys("/", "it") end, { desc = "Search (/)" })
  -- Universal slash
  vim.keymap.set("n", "<leader>z", function() vim.fn.feedkeys("/", "it") end, { desc = "Search (/)" })
  vim.keymap.set("n", "<leader>я", function() vim.fn.feedkeys("/", "it") end, { desc = "Search (/)" })

  -- Window navigation, AstroNvim convention
  vim.keymap.set("n", "<C-р>", "<C-h>", lops)
  vim.keymap.set("n", "<C-о>", "<C-j>", lops)
  vim.keymap.set("n", "<C-л>", "<C-k>", lops)
  vim.keymap.set("n", "<C-д>", "<C-l>", lops)

  -- Frame movement, Vim convention
  vim.keymap.set("n", "<C-а>", "<C-f>", lops)
  vim.keymap.set("n", "<C-и>", "<C-b>", lops)
  vim.keymap.set("n", "<C-в>", "<C-d>", lops)
  vim.keymap.set("n", "<C-г>", "<C-u>", lops)

  -- Wildcats
  vim.keymap.set("n", "<leader>й", "<leader>q", lops)
  vim.keymap.set("n", "<leader>Й", "<leader>Q", lops)
  vim.keymap.set("n", "<leader>ц", "<leader>w", lops)

  -- The (ru) mappings follow https://docs.astronvim.com/mappings
  --
  -- General Mappings, Leader+ only
  vim.keymap.set("n", "<leader>т", "<leader>n", lops)
  vim.keymap.set("n", "<leader>с", "<leader>c", lops)
  vim.keymap.set("n", "<leader>.", "<leader>/", lops)
  -- Buffers
  vim.keymap.set("n", "ъи", "]b", lops)
  vim.keymap.set("n", "хи", "[b", lops)
  vim.keymap.set("n", "<leader>ъи", ">b", lops)
  vim.keymap.set("n", "<leader>хи", "<b", lops)
  vim.keymap.set("n", "<leader>]b", ">b", lops)
  vim.keymap.set("n", "<leader>[b", "<b", lops)
  vim.keymap.set("n", "<leader>ии", "<leader>bb", lops)
  vim.keymap.set("n", "<leader>ис", "<leader>bc", lops)
  vim.keymap.set("n", "<leader>иС", "<leader>bC", lops)
  vim.keymap.set("n", "<leader>ив", "<leader>bd", lops)
  vim.keymap.set("n", "<leader>ид", "<leader>bl", lops)
  vim.keymap.set("n", "<leader>из", "<leader>bp", lops)
  vim.keymap.set("n", "<leader>ик", "<leader>br", lops)
  vim.keymap.set("n", "<leader>иыу", "<leader>bse", lops)
  vim.keymap.set("n", "<leader>иыш", "<leader>bsi", lops)
  vim.keymap.set("n", "<leader>иыь", "<leader>bsm", lops)
  vim.keymap.set("n", "<leader>иыз", "<leader>bsp", lops)
  vim.keymap.set("n", "<leader>иык", "<leader>bsr", lops)
  vim.keymap.set("n", "<leader>и\\", "<leader>b\\", lops)
  vim.keymap.set("n", "<leader>и/", "<leader>b|", lops)
  -- List Management
  vim.keymap.set("n", "<leader>чй", "<leader>xq", lops)
  vim.keymap.set("n", "<leader>чд", "<leader>xl", lops)
  -- Better Escape
  -- Completion
  -- Neo-Tree
  vim.keymap.set("n", "<leader>у", "<leader>e", lops)
  vim.keymap.set("n", "<leader>щ", "<leader>o", lops)
  -- Dashboard Mappings
  vim.keymap.set("n", "<leader>р", "<leader>h", lops)
  -- Session Manager Mappings
  vim.keymap.set("n", "<leader>Ыы", "<leader>Ss", lops)
  vim.keymap.set("n", "<leader>Ыд", "<leader>Sl", lops)
  vim.keymap.set("n", "<leader>Ыв", "<leader>Sd", lops)
  vim.keymap.set("n", "<leader>ЫВ", "<leader>SD", lops)
  vim.keymap.set("n", "<leader>Ыа", "<leader>Sf", lops)
  vim.keymap.set("n", "<leader>ЫА", "<leader>SF", lops)
  vim.keymap.set("n", "<leader>Ыю", "<leader>S.", lops)
  -- Package Management Mappings
  vim.keymap.set("n", "<leader>зф", "<leader>pa", lops)
  vim.keymap.set("n", "<leader>зш", "<leader>pi", lops)
  vim.keymap.set("n", "<leader>зь", "<leader>pm", lops)
  vim.keymap.set("n", "<leader>зЬ", "<leader>pM", lops)
  vim.keymap.set("n", "<leader>зы", "<leader>ps", lops)
  vim.keymap.set("n", "<leader>зЫ", "<leader>pS", lops)
  vim.keymap.set("n", "<leader>зг", "<leader>pu", lops)
  vim.keymap.set("n", "<leader>зГ", "<leader>pU", lops)
  -- LSP Mappings
  vim.keymap.set("n", "<leader>дш", "<leader>li", lops)
  vim.keymap.set("n", "<leader>дШ", "<leader>lI", lops)
  vim.keymap.set("n", "<leader>да", "<leader>lf", lops)
  vim.keymap.set("n", "<leader>дЫ", "<leader>lS", lops)
  vim.keymap.set("n", "<leader>дв", "<leader>ld", lops)
  vim.keymap.set("n", "<leader>дВ", "<leader>lD", lops)
  vim.keymap.set("n", "<leader>дф", "<leader>la", lops)
  vim.keymap.set("n", "<leader>дФ", "<leader>lA", lops)
  vim.keymap.set("n", "<leader>др", "<leader>lh", lops)
  vim.keymap.set("n", "<leader>дк", "<leader>lr", lops)
  vim.keymap.set("n", "<leader>ды", "<leader>ls", lops)
  vim.keymap.set("n", "<leader>дП", "<leader>lG", lops)
  vim.keymap.set("n", "<leader>дК", "<leader>lR", lops)
  -- Debugger Mappings
  vim.keymap.set("n", "<leader>вс", "<leader>dc", lops)
  vim.keymap.set("n", "<leader>вз", "<leader>dp", lops)
  vim.keymap.set("n", "<leader>вк", "<leader>dr", lops)
  vim.keymap.set("n", "<leader>вы", "<leader>ds", lops)
  vim.keymap.set("n", "<leader>вй", "<leader>dq", lops)
  vim.keymap.set("n", "<leader>вЙ", "<leader>dQ", lops)
  vim.keymap.set("n", "<leader>ви", "<leader>db", lops)
  vim.keymap.set("n", "<leader>вС", "<leader>dC", lops)
  vim.keymap.set("n", "<leader>вИ", "<leader>dB", lops)
  vim.keymap.set("n", "<leader>вщ", "<leader>do", lops)
  vim.keymap.set("n", "<leader>вш", "<leader>di", lops)
  vim.keymap.set("n", "<leader>вЩ", "<leader>dO", lops)
  vim.keymap.set("n", "<leader>вУ", "<leader>dE", lops)
  vim.keymap.set("n", "<leader>вК", "<leader>dR", lops)
  vim.keymap.set("n", "<leader>вг", "<leader>du", lops)
  vim.keymap.set("n", "<leader>вр", "<leader>dh", lops)
  -- Telescope Mappings
  vim.keymap.set("n", "<leader>а<CR>", "<leader>f<CR>", lops)
  vim.keymap.set("n", "<leader>аэ", "<leader>f'", lops)
  vim.keymap.set("n", "<leader>аи", "<leader>fb", lops)
  vim.keymap.set("n", "<leader>ас", "<leader>fc", lops)
  vim.keymap.set("n", "<leader>аС", "<leader>fC", lops)
  vim.keymap.set("n", "<leader>аа", "<leader>ff", lops)
  vim.keymap.set("n", "<leader>аА", "<leader>fF", lops)
  vim.keymap.set("n", "<leader>ар", "<leader>fh", lops)
  vim.keymap.set("n", "<leader>ал", "<leader>fk", lops)
  vim.keymap.set("n", "<leader>аь", "<leader>fm", lops)
  vim.keymap.set("n", "<leader>ат", "<leader>fn", lops)
  vim.keymap.set("n", "<leader>ащ", "<leader>fo", lops)
  vim.keymap.set("n", "<leader>ак", "<leader>fr", lops)
  vim.keymap.set("n", "<leader>ае", "<leader>ft", lops)
  vim.keymap.set("n", "<leader>ац", "<leader>fw", lops)
  vim.keymap.set("n", "<leader>аЦ", "<leader>fW", lops)
  vim.keymap.set("n", "<leader>пи", "<leader>gb", lops)
  vim.keymap.set("n", "<leader>пс", "<leader>gc", lops)
  vim.keymap.set("n", "<leader>пС", "<leader>gC", lops)
  vim.keymap.set("n", "<leader>пе", "<leader>gt", lops)
  vim.keymap.set("n", "<leader>ды", "<leader>ls", lops)
  vim.keymap.set("n", "<leader>дП", "<leader>lG", lops)
  -- Terminal Mappings
  vim.keymap.set("n", "<leader>еа", "<leader>tf", lops)
  vim.keymap.set("n", "<leader>ер", "<leader>th", lops)
  vim.keymap.set("n", "<leader>ем", "<leader>tv", lops)
  vim.keymap.set("n", "<leader>ед", "<leader>tl", lops)
  vim.keymap.set("n", "<leader>ет", "<leader>tn", lops)
  vim.keymap.set("n", "<leader>ез", "<leader>tp", lops)
  vim.keymap.set("n", "<leader>ее", "<leader>tt", lops)
  -- UI/UX Mappings
  vim.keymap.set("n", "<leader>гф", "<leader>ua", lops)
  vim.keymap.set("n", "<leader>гФ", "<leader>uA", lops)
  vim.keymap.set("n", "<leader>ги", "<leader>ub", lops)
  vim.keymap.set("n", "<leader>гс", "<leader>uc", lops)
  vim.keymap.set("n", "<leader>гС", "<leader>uC", lops)
  vim.keymap.set("n", "<leader>гв", "<leader>ud", lops)
  vim.keymap.set("n", "<leader>гВ", "<leader>uD", lops)
  vim.keymap.set("n", "<leader>га", "<leader>uf", lops)
  vim.keymap.set("n", "<leader>гА", "<leader>uF", lops)
  vim.keymap.set("n", "<leader>гп", "<leader>ug", lops)
  vim.keymap.set("n", "<leader>гЮ", "<leader>u>", lops)
  vim.keymap.set("n", "<leader>гр", "<leader>uh", lops)
  vim.keymap.set("n", "<leader>гР", "<leader>uH", lops)
  vim.keymap.set("n", "<leader>гш", "<leader>ui", lops)
  vim.keymap.set("n", "<leader>г/", "<leader>u|", lops)
  vim.keymap.set("n", "<leader>гд", "<leader>ul", lops)
  vim.keymap.set("n", "<leader>гД", "<leader>uL", lops)
  vim.keymap.set("n", "<leader>гт", "<leader>un", lops)
  vim.keymap.set("n", "<leader>гТ", "<leader>uN", lops)
  vim.keymap.set("n", "<leader>гз", "<leader>up", lops)
  vim.keymap.set("n", "<leader>гк", "<leader>ur", lops)
  vim.keymap.set("n", "<leader>гК", "<leader>uR", lops)
  vim.keymap.set("n", "<leader>гы", "<leader>us", lops)
  vim.keymap.set("n", "<leader>гЫ", "<leader>uS", lops)
  vim.keymap.set("n", "<leader>ге", "<leader>ut", lops)
  vim.keymap.set("n", "<leader>гг", "<leader>uu", lops)
  vim.keymap.set("n", "<leader>гц", "<leader>uw", lops)
  vim.keymap.set("n", "<leader>гн", "<leader>uy", lops)
  vim.keymap.set("n", "<leader>гН", "<leader>uY", lops)
  vim.keymap.set("n", "<leader>гя", "<leader>uz", lops)
end

return scraps
