-- nvim global
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")
require("config.keymap")
require("config.opt")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.cls",
	callback = function()
		vim.bo.filetype = "apex"
	end,
})
