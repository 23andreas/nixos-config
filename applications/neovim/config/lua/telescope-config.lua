-- Attempt to require 'telescope.builtin'
local ok, builtin = pcall(require, "telescope.builtin")
local ok_telescope, telescope = pcall(require, "telescope")
if not ok or not ok_telescope  then
	print("Failed to load telescope.builtin")
	return
end

telescope.setup{
	defaults = {
		path_display = { "truncate" }
	}
}

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
vim.keymap.set("n", "<leader>ft", builtin.colorscheme, { desc = "Colorschemes" })
vim.keymap.set("n", "<leader>rf", builtin.quickfix, { desc = "Quickfixes" })

