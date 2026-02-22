require("plugins")

require("code")
require("completion")
require("lv-telescope")
require("tree")

--require('gitsigns').setup()
--
vim.o.termguicolors = true
--require('colorizer').setup()


-- init.lua
vim.g.symbols_outline = {
	highlight_hovered_item = true,
	show_guides = true,
	position = "right",
	keymaps = {
		close = "<Esc>",
		goto_location = "<Cr>",
		focus_location = "o",
		hover_symbol = "<C-space>",
		rename_symbol = "r",
		code_actions = "a",
	},
	lsp_blacklist = {},
}
-- Load the ColorScheme
vim.opt.background = "dark"
require("gruvbox").setup({
	undercurl = true,
	underline = true,
	bold = true,
	--italic = true, -- will make italic comments and special strings
	invert_selection = false,
	invert_signs = false,
	invert_tabline = false,
	invert_intend_guides = false,
	contrast = "hard", -- can be "hard" or "light"
	overrides = {},
})
vim.cmd([[colorscheme gruvbox]])
--
-- Font
vim.o.guifont = "PragmataPro Nerd Font:h19"
--
-- -- Settings
-- --
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"
vim.cmd([[map ; :]])
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "kj", "<ESC>", { noremap = true, silent = true })
--
vim.o.fileencoding = "utf-8" -- The encoding written to file
-- Make line numbers default
--vim.wo.number = true
vim.opt.nu = true
vim.opt.relativenumber = true
--
--  Mouse Support
vim.o.mouse = "a"
--
-- --Save undo history
vim.cmd([[ set undofile ]])

--
vim.cmd([[autocmd BufWritePre * :%s/\s\+$//e]]) -- remove trailing whitespaces

--
-- Default Tabs, spaces, wrapping
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.wrap = true
-- --vim.o.textwidth = 85
vim.o.formatoptions = "qrn1"

vim.opt.scrolloff = 8
--
-- Search Settings
-- case insensitive searching
vim.o.ignorecase = true
vim.o.smartcase = true
-- highlight as you type
vim.o.hlsearch = true
vim.o.incsearch = true

vim.o.gdefault = true -- always /g
vim.o.showmatch = true -- show matching braces
--
-- --
vim.o.showmode = true
-- --
vim.o.updatetime = 300 -- Faster completion
--vim.o.timeoutlen = 100 -- By default timeoutlen is 1000 ms
--
vim.o.clipboard = "unnamedplus" -- Copy paste between vim and everything else

-- Highlight on yank
vim.api.nvim_exec(
	[[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
	false
)
--
----
vim.api.nvim_set_keymap("n", "<leader>ev", ":vsplit $HOME/.config/nvim/init.lua<CR>", { noremap = true, silent = true })
--
--Buffers
-- -- vim.api.nvim_set_keymap('n', '<leader>bn', ':BufferNext<CR>', { noremap = true, silent = true })
-- -- vim.api.nvim_set_keymap('n', '<leader>bp', ':BufferPrevious<CR>', { noremap = true, silent = true })
-- -- vim.api.nvim_set_keymap('n', '<leader>bc', ':BufferClose<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<TAB>", ":BufferNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-TAB>", ":BufferPrevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-x>", ":BufferClose<CR>", { noremap = true, silent = true })
-- --
-- --vim.o.splitright = true -- Vertical splits will automatically be to the right
-- --vim.o.splitbelow = true -- Horizontal splits will automatically be below
--
-- Window commands
vim.api.nvim_set_keymap("n", "<leader>wh", ":wincmd h<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>wj", ":wincmd j<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>wk", ":wincmd k<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>wl", ":wincmd l<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ww", ":wincmd w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>wr", ":wincmd r<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>wo", ":wincmd o<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>wx", ":wincmd x<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>wq", ":wincmd q<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ws", ":split <CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>wv", ":vsplit <CR>", { noremap = true, silent = true })

-- Quickfix
--
-- Better nav for omnicomplete
vim.cmd('inoremap <expr> <c-j> ("\\<C-n>")')
vim.cmd('inoremap <expr> <c-k> ("\\<C-p>")')
--
-- -- Explore
vim.api.nvim_set_keymap("n", "<leader>ft", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fr", ":RnvimrToggle<CR>", { noremap = true, silent = true })
--
vim.api.nvim_set_keymap(
	"n",
	"<leader>ff",
	":lua require('telescope.builtin').find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>fg",
	":lua require('telescope.builtin').live_grep()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sp",
	":lua require('telescope.builtin').live_grep()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>bb",
	":lua require('telescope.builtin').buffers()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>fb",
	":lua require('telescope.builtin').buffers()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>fh",
	":lua require('telescope.builtin').help_tags()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>gc",
	[[<cmd>lua require('telescope.builtin').git_commits()<cr>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>gb",
	[[<cmd>lua require('telescope.builtin').git_branches()<cr>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>gs",
	[[<cmd>lua require('telescope.builtin').git_status()<cr>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>gp",
	[[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>ss",
	[[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]],
	{ noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>sd",
	[[<cmd>lua require('telescope.builtin').grep_string()<cr>]],
	{ noremap = true, silent = true }
)
--
--
vim.api.nvim_set_keymap("n", "<leader>K", ":SymbolsOutline<CR>", { noremap = true, silent = true })
