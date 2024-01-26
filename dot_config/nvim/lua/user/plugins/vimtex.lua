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
		keys = {
			-- En
			{ "<leader>lla", ":VimtexContextMenu<CR>", desc = "VimTex context menu" },
			{ "<leader>lli", ":VimtexInfo<CR>", desc = "VimTex current project info" },
			{ "<leader>llI", ":VimtexInfo!<CR>", desc = "VimTex current project info" },
			{ "<leader>llt", ":VimtexTocOpen<CR>", desc = "VimTex open table of contents" },
			{ "<leader>llT", ":VimtexTocToggle<CR>", desc = "VimTex toggle table of contents" },
			{ "<leader>llq", ":VimtexLog<CR>", desc = "VimTex log" },
			{ "<leader>llv", ":VimtexView<CR>", desc = "VimTex view pdf (forward search)" },
			{ "<leader>lll", ":VimtexCompile<CR>", desc = "VimTex compile" },
			{ "<leader>llL", ":VimtexCompileSelected<CR>", desc = "VimTex compile the selected part" },
			{ "<leader>llk", ":VimtexStop<CR>", desc = "VimTex stop compilation for the current project" },
			{ "<leader>llK", ":VimtexStopAll<CR>", desc = "VimTex stop compilation for all projects" },
			{ "<leader>lle", ":VimtexErrors<CR>", desc = "VimTex open quick fix window (err/warn)" },
			{ "<leader>llo", ":VimtexCompileOutput<CR>", desc = "Open file where compiler output is redirected" },
			{ "<leader>llg", ":VimtexStatus<CR>", desc = "VimTex show compilation status for the current project" },
			{ "<leader>llG", ":VimtexStatus!<CR>", desc = "VimTex show compilation status for all projects" },
			{ "<leader>llc", ":VimtexClean<CR>", desc = "VimTex clean auxiliary files" },
			{ "<leader>llC", ":VimtexClean!<CR>", desc = "VimTex clean auxiliary and output files" },
			{ "<leader>llm", ":VimtexImapsList<CR>", desc = "VimTex show imaps list" },
			{ "<leader>llx", ":VimtexReload<CR>", desc = "VimTex reload scripts" },
			{ "<leader>llX", ":VimtexReloadState<CR>", desc = "VimTex reload the state of the current buffer" },
			{ "<leader>lls", ":VimtexToggleMain<CR>", desc = "VimTex toggle main or current file as a target" },
			-- Ru
			{ "<leader>ддф", ":VimtexContextMenu<CR>", desc = "VimTex context menu" },
			{ "<leader>ддш", ":VimtexInfo<CR>", desc = "VimTex current project info" },
			{ "<leader>ддШ", ":VimtexInfo!<CR>", desc = "VimTex current project info" },
			{ "<leader>дде", ":VimtexTocOpen<CR>", desc = "VimTex open table of contents" },
			{ "<leader>ддЕ", ":VimtexTocToggle<CR>", desc = "VimTex toggle table of contents" },
			{ "<leader>ддй", ":VimtexLog<CR>", desc = "VimTex log" },
			{ "<leader>ддм", ":VimtexView<CR>", desc = "VimTex view pdf (forward search)" },
			{ "<leader>ддд", ":VimtexCompile<CR>", desc = "VimTex compile" },
			{ "<leader>ддл", ":VimtexStop<CR>", desc = "VimTex stop compilation for the current project" },
			{ "<leader>ддД", ":VimtexCompileSelected<CR>", desc = "VimTex compile the selected part" },
			{ "<leader>ддЛ", ":VimtexStopAll<CR>", desc = "VimTex stop compilation for all projects" },
			{ "<leader>дду", ":VimtexErrors<CR>", desc = "VimTex open quick fix window (err/warn)" },
			{ "<leader>ддщ", ":VimtexCompileOutput<CR>", desc = "Open file where compiler output is redirected" },
			{ "<leader>ддп", ":VimtexStatus<CR>", desc = "VimTex show compilation status for the current project" },
			{ "<leader>ддП", ":VimtexStatus!<CR>", desc = "VimTex show compilation status for all projects" },
			{ "<leader>ддс", ":VimtexClean<CR>", desc = "VimTex clean auxiliary files" },
			{ "<leader>ддС", ":VimtexClean!<CR>", desc = "VimTex clean auxiliary and output files" },
			{ "<leader>ддь", ":VimtexImapsList<CR>", desc = "VimTex show imaps list" },
			{ "<leader>ддч", ":VimtexReload<CR>", desc = "VimTex reload scripts" },
			{ "<leader>ддЧ", ":VimtexReloadState<CR>", desc = "VimTex reload the state of the current buffer" },
			{ "<leader>дды", ":VimtexToggleMain<CR>", desc = "VimTex toggle main or current file as a target" },
		},
	},
}
