local utils = require("utils")

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- Save with leader key
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { silent = false, desc = "Save" })

-- Quit with leader key
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { silent = false, desc = "Quit" })
vim.keymap.set("n", "<leader>Q", "<cmd>qall<cr>", { silent = false, desc = "Quit" })

-- Save and Quit with leader key
vim.keymap.set("n", "<leader>z", "<cmd>wq<cr>", { silent = false, desc = "Save and quit" })

-- Center buffer while navigating
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "G", "Gzz")
vim.keymap.set("n", "gg", "ggzz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "%", "%zz")
vim.keymap.set("n", "*", "*zz")
vim.keymap.set("n", "#", "#zz")
vim.keymap.set("n", "J", "mzJ`z", { desc = "Keep cursor when J" })

-- Press 'S' for quick find/replace for the word under the cursor
vim.keymap.set("n", "<C-S>", function()
	local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
	local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end, { desc = "Quick find/replace" })

-- Open Spectre for global find/replace
vim.keymap.set("n", "<leader>ss", function()
	require("spectre").toggle()
end, { desc = "Open Spectre" })

-- Open Spectre for global find/replace for the word under the cursor in normal mode
-- TODO Fix, currently being overriden by Telescope
vim.keymap.set("n", "<leader>sw", function()
	require("spectre").open_visual({ select_word = true })
end, { desc = "Search current word" })

-- Press 'H', 'L' to jump to start/end of a line (first/last char)
vim.keymap.set("n", "L", "$", { desc = "Jump to end of a line - last char" })
vim.keymap.set("n", "H", "^", { desc = "Jump to start of a line - first char" })

-- Press 'U' for redo
vim.keymap.set("n", "U", "<C-r>", { desc = "Rendo" })

-- Turn off highlighted results
vim.keymap.set("n", "<leader>no", "<cmd>noh<cr>", { desc = "Turn off highlighted results" })

-- Diagnostics

-- Goto next diagnostic of any severity
vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_next({})
	vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Goto next diagnostic" })

-- Goto previous diagnostic of any severity
vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_prev({})
	vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Goto previous diagnostic" })

-- Goto next error diagnostic
vim.keymap.set("n", "]e", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
	vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Goto next error diagnostic" })

-- Goto previous error diagnostic
vim.keymap.set("n", "[e", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
	vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Goto previous error diagnostic" })

-- Goto next warning diagnostic
vim.keymap.set("n", "]w", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
	vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Goto next warning diagnostic" })

-- Goto previous warning diagnostic
vim.keymap.set("n", "[w", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
	vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Goto previous warning diagnostic" })

-- Open the diagnostic under the cursor in a float window
vim.keymap.set("n", "<leader>d", function()
	vim.diagnostic.open_float({
		border = "rounded",
	})
end, { desc = "Open diagnostic under cursor in a float window" })

-- Resize split windows to be equal size
vim.keymap.set("n", "<leader>=", "<C-w>=", { desc = "Resize split windows to be equal size" })

vim.keymap.set("n", "<C-c>", "<Esc>", { desc = "Rempa ctrl-c to esc" })

-- Paste/Copy/Delete
vim.keymap.set("n", "<leader>p", [["_dp"]], { desc = "Paste without coping" })
vim.keymap.set("n", "<leader>y", [["+y"]], { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y"]], { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>D", [["_d"]], { desc = "Delete to the void" })
vim.keymap.set("x", "<leader>p", [["_dp"]], { desc = "Paste without coping" })
vim.keymap.set("x", "<leader>y", [["+y"]], { desc = "Yank to clipboard" })
vim.keymap.set("x", "<leader>Y", [["+Y"]], { desc = "Yank to clipboard" })
vim.keymap.set("x", "<leader>D", [["_d"]], { desc = "Delete to the void" })

-- Move Lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Symbols Outline
vim.keymap.set("n", "<leader>lo", "<cmd>SymbolsOutline<CR>", { desc = "Symbols outline" })

-- Split
vim.keymap.set("n", "|", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
vim.keymap.set("n", "\\", "<cmd>split<cr>", { desc = "Horizontal Split" })

-- Plugin Manager
vim.keymap.set("n", "<leader>pi", function()
	require("lazy").install()
end, { desc = "Plugins Install" })
vim.keymap.set("n", "<leader>ps", function()
	require("lazy").home()
end, { desc = "Plugins Status" })
vim.keymap.set("n", "<leader>pS", function()
	require("lazy").sync()
end, { desc = "Plugins Sync" })
vim.keymap.set("n", "<leader>pu", function()
	require("lazy").check()
end, { desc = "Plugins Check Updates" })
vim.keymap.set("n", "<leader>pU", function()
	require("lazy").update()
end, { desc = "Plugins Update" })

-- Buffers
vim.keymap.set("n", "<leader>c", function()
	require("astronvim.utils.buffer").close()
end, { desc = "Close buffer" })
vim.keymap.set("n", "<leader>C", function()
	require("astronvim.utils.buffer").close(0, true)
end, { desc = "Force close buffer" })

-- smartsplits
vim.keymap.set("n", "<C-h>", function()
	require("smart-splits").move_cursor_left()
end, { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", function()
	require("smart-splits").move_cursor_down()
end, { desc = "Move to below split" })
vim.keymap.set("n", "<C-k>", function()
	require("smart-splits").move_cursor_up()
end, { desc = "Move to above split" })
vim.keymap.set("n", "<C-l>", function()
	require("smart-splits").move_cursor_right()
end, { desc = "Move to right split" })
vim.keymap.set("n", "<C-Up>", function()
	require("smart-splits").resize_up()
end, { desc = "Resize split up" })
vim.keymap.set("n", "<C-Down>", function()
	require("smart-splits").resize_down()
end, { desc = "Resize split down" })
vim.keymap.set("n", "<C-Left>", function()
	require("smart-splits").resize_left()
end, { desc = "Resize split left" })
vim.keymap.set("n", "<C-Right>", function()
	require("smart-splits").resize_right()
end, { desc = "Resize split right" })

-- Terminal
vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "ToggleTerm float" })
vim.keymap.set(
	"n",
	"<leader>th",
	"<cmd>ToggleTerm size=10 direction=horizontal<cr>",
	{ desc = "ToggleTerm horizontal split" }
)
vim.keymap.set(
	"n",
	"<leader>tv",
	"<cmd>ToggleTerm size=80 direction=vertical<cr>",
	{ desc = "ToggleTerm vertical split" }
)
vim.keymap.set("n", "<F7>", '<Cmd>execute v:count . "ToggleTerm"<CR>', { desc = "Toggle terminal" })
vim.keymap.set("i", "<F7>", '<Esc><Cmd>exevute v:count . "ToggleTerm"<CR>', { desc = "Toggle terminal" })
vim.keymap.set("t", "<F7>", '<Cmd>execute v:count . "ToggleTerm"<CR>', { desc = "Toggle terminal " })
vim.keymap.set("n", "<C-'>", '<Cmd>execute v:count . "ToggleTerm"<CR>', { desc = "Toggle terminal" })
vim.keymap.set("i", "<C-'>", '<Esc><Cmd>exevute v:count . "ToggleTerm"<CR>', { desc = "Toggle terminal" })
vim.keymap.set("t", "<C-'>", '<Cmd>execute v:count . "ToggleTerm"<CR>', { desc = "Toggle terminal " })
vim.keymap.set("t", "<C-x>", [[<C-\><C-n>]], { desc = "Terminal normal mode" })
-- vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>:q<cr>", { desc = "Terminal quit" })
vim.keymap.set("t", "<C-\\>", "<cmd>ToggleTerm direction=float<cr>", { desc = "ToggleTerm float" })
vim.keymap.set("n", "<C-\\>", "<cmd>ToggleTerm direction=float<cr>", { desc = "ToggleTerm float" })

vim.keymap.set("n", "zR", function()
	require("ufo").openAllFolds()
end, { desc = "Open all folds" })
vim.keymap.set("n", "zM", function()
	require("ufo").closeAllFolds()
end, { desc = "Close all folds" })
vim.keymap.set("n", "zr", function()
	require("ufo").openFoldsExceptKinds()
end, { desc = "Fold less" })
vim.keymap.set("n", "zm", function()
	require("ufo").closeFoldsWith()
end, { desc = "Fold more" })
vim.keymap.set("n", "zp", function()
	require("ufo").peekFoldedLinesUnderCursor()
end, { desc = "Peek fold" })

-- Stay in indent mode
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Unindent line" })
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent line" })

-- Improved Terminal Navigation
vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Terminal left window navigation" })
vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Terminal down window navigation" })
vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Terminal up window navigation" })
vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Terminal right window navigation" })

-- UI
vim.keymap.set("n", "<leader>ua", utils.toggle_autopairs, { desc = "Toggle autopairs" })
vim.keymap.set("n", "<leader>uc", utils.toggle_cmp, { desc = "Toggle autocompletion" })
vim.keymap.set("n", "<leader>uC", "<cmd>ColorizerToggle<cr>", { desc = "Toggle color highlight" })
vim.keymap.set("n", "<leader>ug", utils.toggle_signcolumn, { desc = "Toggle signcolumn" })
vim.keymap.set("n", "<leader>ui", utils.set_indent, { desc = "Change indent setting" })
vim.keymap.set("n", "<leader>ul", utils.toggle_statusline, { desc = "Toggle statusline" })
vim.keymap.set("n", "<leader>uL", utils.toggle_codelens, { desc = "Toggle CodeLens" })
vim.keymap.set("n", "<leader>un", utils.change_number, { desc = "Change line numbering" })
vim.keymap.set("n", "<leader>uN", utils.toggle_ui_notifications, { desc = "Toggle Notifications" })
vim.keymap.set("n", "<leader>up", utils.toggle_paste, { desc = "Toggle paste mode" })
vim.keymap.set("n", "<leader>us", utils.toggle_spell, { desc = "Toggle spellcheck" })
vim.keymap.set("n", "<leader>uS", utils.toggle_conceal, { desc = "Toggle conceal" })
vim.keymap.set("n", "<leader>ut", utils.toggle_tabline, { desc = "Toggle tabline" })
vim.keymap.set("n", "<leader>uw", utils.toggle_wrap, { desc = "Toggle wrap" })
vim.keymap.set("n", "<leader>uy", utils.toggle_syntax, { desc = "Toggle syntax highlighting (buffer)" })
vim.keymap.set("n", "<leader>uh", utils.toggle_foldcolumn, { desc = "Toggle foldcolumn" })
vim.keymap.set("n", "<leader>uf", utils.toggle_buffer_autoformat, { desc = "Toggle autoformatting (buffer)" })
vim.keymap.set("n", "<leader>uF", utils.toggle_autoformat, { desc = "Toggle foldcolumn" })

vim.keymap.set("n", "<leader>Ff", "<cmd>Telescope flutter commands<CR>", { desc = "Flutter" })
vim.keymap.set("n", "<leader>Fe", "<cmd>FlutterEmulators<CR>", { desc = "Flutter Emulators" })
vim.keymap.set("n", "<leader>Fd", "<cmd>FlutterDevices<CR>", { desc = "Flutter Devices" })
vim.keymap.set("n", "<leader>Fr", "<cmd>FlutterReload<CR>", { desc = "Flutter Reload" })
vim.keymap.set("n", "<leader>FR", "<cmd>FlutterRestart<CR>", { desc = "Flutter Restart" })
vim.keymap.set("n", "<leader>Fo", "<cmd>FlutterOutlineToggle<CR>", { desc = "Flutter Outline" })
vim.keymap.set("n", "<leader>Fs", "<cmd>FlutterRun<CR>", { desc = "Flutter Run Project" })

-- ia complete keymap
vim.keymap.set("i", "<A-Tab>", "codeium#Accept()", {
	expr = true,
	replace_keycodes = false,
})
