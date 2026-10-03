return function()
  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  local opts = { noremap=true, silent=true }
  local function diagnostic_jump(count)
    vim.diagnostic.jump({
      count = count,
      on_jump = function(diagnostic, bufnr)
        if diagnostic then
          vim.diagnostic.open_float({ bufnr = bufnr, scope = 'cursor', focus = false })
        end
      end,
    })
  end
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', function() diagnostic_jump(-1) end, opts)
  vim.keymap.set('n', ']d', function() diagnostic_jump(1) end, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(_, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buf=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    -- Neovim selects attached clients that support formatting.
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  end

  -- Setup language servers using vim.lsp.config (Neovim 0.11+)
  -- Uncomment the ones you need and ensure the LSP server is installed

  -- TypeScript/JavaScript (npm install -g typescript-language-server typescript@6)
  -- vim.lsp.config.ts_ls = {
  --   cmd = { 'typescript-language-server', '--stdio' },
  --   on_attach = on_attach,
  -- }
  -- vim.lsp.enable('ts_ls')

  -- TypeScript/JavaScript (npm install -g typescript@7)
  vim.lsp.config.tsc = {
    cmd = { 'tsc', '--lsp', '--stdio' },
    filetypes = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
    },
    root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
    on_attach = on_attach,
  }
  vim.lsp.enable('tsc')

  -- Python (pip install pyright)
  vim.lsp.config.pyright = {
    cmd = { 'pyright-langserver', '--stdio' },
    before_init = function(_, config)
      if not config.root_dir then return end
      local python = vim.fs.joinpath(config.root_dir, '.venv', 'bin', 'python')
      if vim.fn.executable(python) == 1 then
        config.settings = config.settings or {}
        config.settings.python = config.settings.python or {}
        config.settings.python.pythonPath = python
      end
    end,
    on_attach = on_attach,
  }
  vim.lsp.enable('pyright')

  -- Ruby (gem install ruby-lsp)
  vim.lsp.config.ruby_lsp = {
    cmd = { 'ruby-lsp' },
    on_attach = on_attach,
  }
  vim.lsp.enable('ruby_lsp')

  -- Lua (brew install lua-language-server)
  -- vim.lsp.config.lua_ls = {
  --   cmd = { 'lua-language-server' },
  --   on_attach = on_attach,
  -- }
  -- vim.lsp.enable('lua_ls')

  -- CSS (npm install -g vscode-langservers-extracted)
  -- vim.lsp.config.cssls = {
  --   cmd = { 'vscode-css-language-server', '--stdio' },
  --   on_attach = on_attach,
  -- }
  -- vim.lsp.enable('cssls')

  -- HTML (npm install -g vscode-langservers-extracted)
  -- vim.lsp.config.html = {
  --   cmd = { 'vscode-html-language-server', '--stdio' },
  --   on_attach = on_attach,
  -- }
  -- vim.lsp.enable('html')

  -- JSON (npm install -g vscode-langservers-extracted)
  -- vim.lsp.config.jsonls = {
  --   cmd = { 'vscode-json-language-server', '--stdio' },
  --   on_attach = on_attach,
  -- }
  -- vim.lsp.enable('jsonls')
end
