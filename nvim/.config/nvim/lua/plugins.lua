local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

return require("packer").startup(
    function(use)
        -- Packer can manage itself as an optional plugin
        use "wbthomason/packer.nvim"

         -- Languages support
        use "sheerun/vim-polyglot"

        -- -- Color
        --use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
        use { "ellisonleao/gruvbox.nvim" }
        --use 'eddyekofo94/gruvbox-flat.nvim'

        --use 'folke/tokyonight.nvim'
        use 'arcticicestudio/nord-vim'
        use {"norcalli/nvim-colorizer.lua"}

        -- -- Dasboard
        -- --use "ChristianChiarulli/dashboard-nvim"
        use "mhinz/vim-startify"

        -- -- TODO refactor all of this (for now it works, but yes I know it could be wrapped in a simpler function)
        use "neovim/nvim-lspconfig"
        use "glepnir/lspsaga.nvim"
        -- use "kabouzeid/nvim-lspinstall"
        use "folke/lsp-trouble.nvim"
        use "folke/lsp-colors.nvim"
        --use 'onsails/lspkind-nvim' use 'folke/lsp-colors.nvim'

        -- Telescope

        use {
        "nvim-telescope/telescope.nvim",
             requires = {
                 {"nvim-lua/popup.nvim"},
                 {"nvim-lua/plenary.nvim"},
                 {'nvim-telescope/telescope-media-files.nvim'}
             }
        }
        -- -- Formating
        use 'sbdchd/neoformat'
        -- -- Autocomplete
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-path'
        use 'hrsh7th/cmp-cmdline'
        use "hrsh7th/nvim-cmp"

        use "hrsh7th/vim-vsnip"
        use "rafamadriz/friendly-snippets"

        -- -- Treesitter
        use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
        use "windwp/nvim-ts-autotag"

        -- -- Eplorer
        use "kyazdani42/nvim-tree.lua"
        -- use "preservim/nerdtree"
        use "kevinhwang91/rnvimr"

        use "terrortylor/nvim-comment"

        use "kevinhwang91/nvim-bqf" -- improve quickfix

        -- use "liuchengxu/vim-which-key"
        -- --
        -- Tagbar
        --use "liuchengxu/vista.vim"
        use "simrat39/symbols-outline.nvim"

        -- -- Icons
        -- use "kyazdani42/nvim-web-devicons"

        -- -- Status Line and Bufferline
        -- use "glepnir/galaxyline.nvim"
        -- --use 'bling/vim-airline'
        use {'hoob3rt/lualine.nvim',
            requires = {'kyazdani42/nvim-web-devicons', opt = true},
        }
        --
        -- -- bar
        use "romgrk/barbar.nvim"

        --Tpope
        -- -- use 'tpope/vim-commentary'
        use 'tpope/vim-surround'
        use 'tpope/vim-fugitive'
        use 'tpope/vim-unimpaired'

        use 'windwp/nvim-autopairs'
        -- use 'p00f/nvim-ts-rainbow'

        use {
           'lewis6991/gitsigns.nvim',
           requires = {
             'nvim-lua/plenary.nvim'
           }
        }
        -- -- use 'airblade/vim-gitgutter' -- shows git changes in gutter

        --Python
        -- --use 'alfredodeza/pytest.vim'
        -- --use 'heavenshell/vim-pydocstring'
        use 'kkoomen/vim-doge'

        -- Debug
        use 'mfussenegger/nvim-dap'
        use 'mfussenegger/nvim-dap-python'

        -- Testing
        -- use { "rcarriga/vim-ultest", requires = {"janko/vim-test"}, run = ":UpdateRemotePlugins" }
        -- --
        use 'lambdalisue/suda.vim'

        -- ---
        use {'lukas-reineke/indent-blankline.nvim', branch='master'}
        -- --
        -- use 'airblade/vim-rooter'
        use 'ahmedkhalf/project.nvim'
        -- --
        use 'jpalardy/vim-slime'

        --
        use 'Konfekt/FastFold'
        use 'tmhedberg/SimpylFold'

        use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
        -- Git diff
        --
        use 'sindrets/diffview.nvim'

        -- Jupyter
        use 'goerz/jupytext.vim'

        -- Orgmode
        use {'nvim-orgmode/orgmode', config = function()
            require('orgmode').setup{}
        end
        }

        -- term
        use 'kassio/neoterm'
        --rust
        use "simrat39/rust-tools.nvim"

    end
)
