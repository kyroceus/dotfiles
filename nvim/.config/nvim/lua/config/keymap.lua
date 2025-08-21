vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>")
vim.keymap.set({ "n", "v", "x" }, "<leader>w", ":write<CR>")
vim.keymap.set({ "n", "v", "x" }, "<leader>q", ":quit<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")
