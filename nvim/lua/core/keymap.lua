--- keymap configurations

local keymap = vim.keymap

keymap.set("v", "J", ":m '>+1<CR>gv=gv'")
keymap.set("v", "K", ":m '<-2<CR>gv=gv'")

keymap.set("n", "<leader>sv", "<C-w>v")
keymap.set("n", "<leader>sh", "<C-w>s")

keymap.set("n", "<leader>nh", ":nohl<CR>")

--- Plugin Keymap
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

keymap.set("n", "<leader>d", function ()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local row, col = cursor_pos[1] - 1, cursor_pos[2]

	local diagnostics = vim.diagnostic.get(0, { lnum = row })

	if #diagnostics > 0 then
		vim.diagnostic.open_float({
			scope = "cursor",
			header = "Diagnostics:",
			format = function (d)
				return string.format("%s [%s]", d.message, d.source or "unknown")
			end,
			close_events = { "CursorMoved", "InsertEnter" },
		})
	else
		vim.notify("No diagnostics found", vim.log.levels.INFO)
	end
end, { desc = "Diagnostics Float Panel" })
