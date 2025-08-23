return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"astro",
					"bash",
					"c",
					"diff",
					"html",
					"lua",
					"luadoc",
					"markdown",
					"markdown_inline",
					"query",
					"vim",
					"vimdoc",
					"javascript",
					"apex",
				},
				highlight = {
					enable = true,
				},
				sync_install = false,
				ignore_install = {},
				auto_install = true,
				modules = {},
			})
		end,
	},
}
