-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{
			"mason-org/mason-lspconfig.nvim",
			opts = {},
			dependencies = {
				{ "mason-org/mason.nvim", opts = {} },
				"neovim/nvim-lspconfig",
			},
		},
		-- add your plugins here
		-- Languages support
		-- "sheerun/vim-polyglot"
		-- Color
		"ellisonleao/gruvbox.nvim",
		-- Dashboard
		{
			"goolord/alpha-nvim",
			-- dependencies = { 'nvim-mini/mini.icons' },
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function()
				local startify = require("alpha.themes.startify")
				-- available: devicons, mini, default is mini
				-- if provider not loaded and enabled is true,
				-- it will try to use another provider
				startify.file_icons.provider = "devicons"
				require("alpha").setup(startify.config)
			end,
		},
		-- "mhinz/vim-startify"
		-- Statusline
		{
			"nvim-lualine/lualine.nvim",
            opts = {
                theme = "gruvbox",
            },
			dependencies = { "nvim-tree/nvim-web-devicons" },
		},
		{
			"romgrk/barbar.nvim",
			dependencies = {
				"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
				"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
			},
			init = function()
				vim.g.barbar_auto_setup = false
			end,
			opts = {
				-- lazy.nvim will automatically call setup for you.
                -- put your options here, anything missing will use the default:
				-- animation = true,
				-- insert_at_start = true,
				-- …etc.
			},
            version = '^1.0.0', -- optional: only update when a new 1.x version is released
		},

		--Tpope
		-- 'tpope/vim-commentary'
		"tpope/vim-surround",
		"tpope/vim-fugitive",
		"tpope/vim-unimpaired",
		{
			"nvim-treesitter/nvim-treesitter",
			lazy = false,
			build = ":TSUpdate",
		},
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = true,
			-- use opts = {} for passing setup options
			-- this is equivalent to setup({}) function
		},
		-- Eplorer
		"kyazdani42/nvim-tree.lua",
		-- Language Server
		"neovim/nvim-lspconfig",
		-- Telescope - find stuff
		{
			"nvim-telescope/telescope.nvim",
			version = "*",
			dependencies = {
				"nvim-lua/plenary.nvim",
				-- optional but recommended
				{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			},
		},
		-- Formating
		"sbdchd/neoformat",
		-- Comment
		"terrortylor/nvim-comment",

		-- Autocomplete
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		--
		{
			"folke/trouble.nvim",
			opts = {}, -- for default options, refer to the configuration section for custom setup.
			cmd = "Trouble",
		},
		--
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = false},
})

-- Old plugins check
--         use "hrsh7th/vim-vsnip"
--         use "rafamadriz/friendly-snippets"
--
--         use "kevinhwang91/rnvimr"
--
--
--         use "kevinhwang91/nvim-bqf" -- improve quickfix
--
--         use "simrat39/symbols-outline.nvim"
--
--         use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}
--         use {
--              'romgrk/barbar.nvim',
--              requires = 'nvim-web-devicons'
--         }
--
--
--         use {
--            'lewis6991/gitsigns.nvim',
--            requires = {
--              'nvim-lua/plenary.nvim'
--            }
--         }
--         --Python
--         -- --use 'alfredodeza/pytest.vim'
--         -- --use 'heavenshell/vim-pydocstring'
--         use 'kkoomen/vim-doge'
--
--         -- Debug
--         use 'mfussenegger/nvim-dap'
--         use 'mfussenegger/nvim-dap-python'
--
--         -- Testing
--         -- --
--         use 'lambdalisue/suda.vim'
--
--         -- ---
--         use {'lukas-reineke/indent-blankline.nvim', branch='master'}
--         -- --
--         -- --
--         use 'jpalardy/vim-slime'
--
--         --
--         use 'Konfekt/FastFold'
--         use 'tmhedberg/SimpylFold'
--
--         use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
--         -- Git diff
--         --
--         use 'sindrets/diffview.nvim'
--
--         -- term
--         use 'kassio/neoterm'
--         --rust
--         --use "simrat39/rust-tools.nvim"
