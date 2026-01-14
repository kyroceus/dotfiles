return {
	{
		"sainnhe/everforest",
		config = function()
			vim.g.everforest_transparent_background = 1
			vim.cmd.colorscheme("everforest")
			vim.api.nvim_set_hl(0, "CursorLine", { bg = "#232a25" })
		end,
	},
}
