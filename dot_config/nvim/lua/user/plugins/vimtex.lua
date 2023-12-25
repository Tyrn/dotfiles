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
		keys = {
			{ "<leader>poa", ":PoetvActivate<CR>", desc = "Poetry activate" },
			{ "<leader>pod", "<cmd>PoetvDeactivate<cr>", desc = "Poetry deactivate" },
			{ "<leader>lla", ":VimtexContextMenu<CR>", desc = "VimTex context menu" },
			{ "<leader>ддф", ":VimtexContextMenu<CR>", desc = "VimTex context menu" },
			{ "<leader>lli", ":VimtexInfo<CR>", desc = "VimTex current project info" },
			{ "<leader>ддш", ":VimtexInfo<CR>", desc = "VimTex current project info" },
			{ "<leader>llI", ":VimtexInfo!<CR>", desc = "VimTex current project info" },
			{ "<leader>ддШ", ":VimtexInfo!<CR>", desc = "VimTex current project info" },
			{ "<leader>llt", ":VimtexTocOpen<CR>", desc = "VimTex open table of contents" },
			{ "<leader>дде", ":VimtexTocOpen<CR>", desc = "VimTex open table of contents" },
			{ "<leader>llT", ":VimtexTocToggle<CR>", desc = "VimTex toggle table of contents" },
			{ "<leader>ддЕ", ":VimtexTocToggle<CR>", desc = "VimTex toggle table of contents" },
			{ "<leader>llq", ":VimtexLog<CR>", desc = "VimTex log" },
			{ "<leader>ддй", ":VimtexLog<CR>", desc = "VimTex log" },
			{ "<leader>llv", ":VimtexView<CR>", desc = "VimTex view pdf (forward search)" },
			{ "<leader>ддм", ":VimtexView<CR>", desc = "VimTex view pdf (forward search)" },
			{ "<leader>lll", ":VimtexCompile<CR>", desc = "VimTex compile" },
			{ "<leader>ддд", ":VimtexCompile<CR>", desc = "VimTex compile" },
			{ "<leader>llL", ":VimtexCompileSelected<CR>", desc = "VimTex compile the selected part" },
			{ "<leader>ддД", ":VimtexCompileSelected<CR>", desc = "VimTex compile the selected part" },
			{ "<leader>llk", ":VimtexStop<CR>", desc = "VimTex stop compilation for the current project" },
			{ "<leader>ддл", ":VimtexStop<CR>", desc = "VimTex stop compilation for the current project" },
			{ "<leader>llK", ":VimtexStopAll<CR>", desc = "VimTex stop compilation for all projects" },
			{ "<leader>ддЛ", ":VimtexStopAll<CR>", desc = "VimTex stop compilation for all projects" },
			{ "<leader>lle", ":VimtexErrors<CR>", desc = "VimTex open quick fix window (err/warn)" },
			{ "<leader>дду", ":VimtexErrors<CR>", desc = "VimTex open quick fix window (err/warn)" },
			{ "<leader>llo", ":VimtexCompileOutput<CR>", desc = "Open file where compiler output is redirected" },
			{ "<leader>ддщ", ":VimtexCompileOutput<CR>", desc = "Open file where compiler output is redirected" },
			{ "<leader>llg", ":VimtexStatus<CR>", desc = "VimTex show compilation status for the current project" },
			{ "<leader>ддп", ":VimtexStatus<CR>", desc = "VimTex show compilation status for the current project" },
			{ "<leader>llG", ":VimtexStatus!<CR>", desc = "VimTex show compilation status for all projects" },
			{ "<leader>ддП", ":VimtexStatus!<CR>", desc = "VimTex show compilation status for all projects" },
			{ "<leader>llc", ":VimtexClean<CR>", desc = "VimTex clean auxiliary files" },
			{ "<leader>ддс", ":VimtexClean<CR>", desc = "VimTex clean auxiliary files" },
			{ "<leader>llC", ":VimtexClean!<CR>", desc = "VimTex clean auxiliary and output files" },
			{ "<leader>ддС", ":VimtexClean!<CR>", desc = "VimTex clean auxiliary and output files" },
			{ "<leader>llm", ":VimtexImapsList<CR>", desc = "VimTex show imaps list" },
			{ "<leader>ддь", ":VimtexImapsList<CR>", desc = "VimTex show imaps list" },
			{ "<leader>llx", ":VimtexReload<CR>", desc = "VimTex reload scripts" },
			{ "<leader>ддч", ":VimtexReload<CR>", desc = "VimTex reload scripts" },
			{ "<leader>llX", ":VimtexReloadState<CR>", desc = "VimTex reload the state of the current buffer" },
			{ "<leader>ддЧ", ":VimtexReloadState<CR>", desc = "VimTex reload the state of the current buffer" },
			{ "<leader>lls", ":VimtexToggleMain<CR>", desc = "VimTex toggle main or current file as a target" },
			{ "<leader>дды", ":VimtexToggleMain<CR>", desc = "VimTex toggle main or current file as a target" },
		},
	},
}
