local saga = require 'lspsaga'

saga.init_lsp_saga {
  error_sign = "",--   
  error_sign = "",--   
  warn_sign = "",--  
  infor_sign = "",--  
  hint_sign = "",--    
  border_style = 2,
  code_action_icon = '💡',
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 20,
    virtual_text = false,
  },
  code_action_keys = { quit = {'q', '<ESC>'}, exec = '<CR>' },
}

local on_attach = function(client, bufnr)

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    --mappings
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    --Goto previous/next diagnostic warning/error
    buf_set_keymap('n', 'g[', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', 'g]', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)

    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gk', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)

    buf_set_keymap('n', 'ca', '<cmd>Lspsaga code_action<CR>', opts)
    buf_set_keymap('n', 'rn', "<cmd>lua require('lspsaga.rename').rename()<CR>", opts)
    buf_set_keymap('n', 'gh', "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", opts)

    buf_set_keymap('n', '<C-p>', "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", opts)
    buf_set_keymap('n', '<C-n>', "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", opts)
    -- scroll down hover doc or scroll in definition preview
    buf_set_keymap('n', '<C-f>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)
    -- scroll up hover doc
    buf_set_keymap('n', '<C-b>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)
end

vim.cmd('command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')


local lspconfig = require('lspconfig')

lspconfig.pyright.setup{
    on_attach = on_attach;
    filetypes = { "python" };
}

lspconfig.ccls.setup{
  init_options = {
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    clang = {
      excludeArgs = { "-frounding-math"} ;
    };
  }
}

lspconfig.rust_analyzer.setup {
}


local black = {
    formatCommand = "black -",
    formatStdin = true
}

local isort = {
    formatCommand = "isort --stdout --profile black -",
    formatStdin = true
}

local flake8 = {
    lintCommand = "flake8 --stdin-display-name ${INPUT} -",
    lintStdin = true,
    lintIgnoreExitCode = true,
    lintFormats = {"%f:%l:%c: %m"}
}

local mypy = {
    lintCommand = "mypy --show-column-numbers --ignore-missing-imports",
    lintFormats = {"%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m"}
}

lspconfig.efm.setup({
    --on_attach = on_attach,
    --init_options = {documentFormatting = true},
   -- root_dir = require'lspconfig.util'.root_pattern(vim.fn.getcwd()),
    --handlers = require'modules.lang.lsp.lspconfig.utils'.diagnostics,
    --capabilities = require'modules.lang.lsp.servers'.capabilities,
    --on_attach = require'modules.lang.lsp.servers'.enhance_attach,
    --root_dir = require'lspconfig.util'.root_pattern(vim.fn.getcwd()),
    root_dir = function() return vim.fn.getcwd() end;
    init_options = {documentFormatting = true, codeAction = false},
    filetypes = {"python"},
    settings = {
        rootMarkers = {"requirements.txt" --,
                       -- ".git/"
                    },
        languages = {
            ["="] = {},
            python = {flake8, isort, mypy}
        }
    }
})


require("trouble").setup {
}
-- Lua
require("lsp-colors").setup({
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
})

--require('lspkind').init({
    -- with_text = true,
    -- symbol_map = {
    --   Text = '',
    --   Method = 'ƒ',
    --   Function = '',
    --   Constructor = '',
    --   Variable = '',
    --   Class = '',
    --   Interface = 'ﰮ',
    --   Module = '',
    --   Property = '',
    --   Unit = '',
    --   Value = '',
    --   Enum = '了',
    --   Keyword = '',
    --   Snippet = '﬌',
    --   Color = '',
    --   File = '',
    --   Folder = '',
    --   EnumMember = '',
    --   Constant = '',
    --   Struct = ''
    -- },
--})
