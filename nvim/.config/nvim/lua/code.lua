local on_attach = function(client, bufnr)

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    --mappings
    local opts = { noremap=true, silent=true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
    --Goto previous/next diagnostic warning/error
    vim.keymap.set('n', 'g[', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', 'g]', vim.diagnostic.goto_prev, opts)

    vim.keymap.set('n', 'K',  vim.lsp.buf.hover, opts)
    -- buf_set_keymap('n', 'gk', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
    --
    -- buf_set_keymap('n', '<C-p>', "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", opts)
    -- buf_set_keymap('n', '<C-n>', "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", opts)
    -- buf_set_keymap('n', '<C-b>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)
end

vim.lsp.config('luals', {
       -- Command and arguments to start the server.
       cmd = { 'lua-language-server' },

       -- Filetypes to automatically attach to.
       filetypes = { 'lua' },

       -- Sets the "root directory" to the parent directory of the file in the
       -- current buffer that contains either a ".luarc.json" or a
       -- ".luarc.jsonc" file. Files that share a root directory will reuse
       -- the connection to the same LSP server.
       -- Nested lists indicate equal priority, see |vim.lsp.Config|.
       root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },

       -- Specific settings to send to the server. The schema for this is
       -- defined by the server. For example the schema for lua-language-server
       -- can be found here https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
       settings = {
         Lua = {
           runtime = {
             version = 'LuaJIT',
           }
         }
       }
    })
--
vim.lsp.config('ruff', {
    autostart = true
})
vim.lsp.enable('ruff')

vim.lsp.config('pyright', {
    on_attach = on_attach,
    --filetypes = {"python"},
    autostart  = true,
    settings = {
      python = {
        analysis = {
          -- Ignore all ifiles for analysis - Use ruff for linting
          --ignore = {'*'}
        }
      }
    }
  })
vim.lsp.enable('pyright')
