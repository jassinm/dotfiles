-- Plugins
vim.pack.add({
  -- LSP / Mason
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },

  -- Colorscheme
  { src = "https://github.com/ellisonleao/gruvbox.nvim" },

  -- UI
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/goolord/alpha-nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/romgrk/barbar.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },

  -- Tpope
  { src = "https://github.com/tpope/vim-surround" },
  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/tpope/vim-unimpaired" },

  -- Treesitter
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },

  -- Editing
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/terrortylor/nvim-comment" },
  { src = "https://github.com/sbdchd/neoformat" },

  -- Explorer
  { src = "https://github.com/kyazdani42/nvim-tree.lua" },

  -- Telescope
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  -- Completion
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-path" },
  { src = "https://github.com/hrsh7th/cmp-cmdline" },

  -- Trouble
  { src = "https://github.com/folke/trouble.nvim" },

  -- Slime
  { src = "https://github.com/jpalardy/vim-slime" },
})

-- =========================
-- Configs (manual now)
-- =========================

-- Mason
require("mason").setup()
require("mason-lspconfig").setup()

-- Lualine
require("lualine").setup({
  options = { theme = "gruvbox" },
})

-- Alpha dashboard
local startify = require("alpha.themes.startify")
startify.file_icons.provider = "devicons"
require("alpha").setup(startify.config)

-- Barbar
vim.g.barbar_auto_setup = false
require("barbar").setup({})

-- Treesitter
-- require("nvim-treesitter.configs").setup({
--   highlight = { enable = true },
-- })

-- Autopairs
require("nvim-autopairs").setup({})

-- Telescope
require("telescope").setup({})

-- Trouble
require("trouble").setup({})

-- Gruvbox
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

-- vim-slime
vim.g.slime_target = "tmux"
vim.g.slime_default_config = {
  socket_name = "default",
  target_pane = "{last}",
}
vim.g.slime_dont_ask_default = 1
vim.g.slime_python_ipython = 1
