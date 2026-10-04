return function()
  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  local opts = { silent=true }
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

  local group = vim.api.nvim_create_augroup('DotvimLspAttach', { clear = true })
  vim.api.nvim_create_autocmd('LspAttach', {
    group = group,
    callback = function(event)
      local bufnr = event.buf
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

      -- Mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local bufopts = { silent=true, buf=bufnr }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', '<space>k', vim.lsp.buf.signature_help, bufopts)
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
    end,
  })

  -- Install each language server before enabling it.

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
  }
  vim.lsp.enable('tsc')

  -- Python (pip install pyright)
  vim.lsp.config.pyright = {
    cmd = { 'pyright-langserver', '--stdio' },
    before_init = function(_, config)
      local settings = config.settings or {}
      local python_settings = settings.python or {}
      if python_settings.pythonPath and python_settings.pythonPath ~= '' then return end
      if not config.root_dir then return end
      local executable = vim.fn.has('win32') == 1
        and { '.venv', 'Scripts', 'python.exe' }
        or { '.venv', 'bin', 'python' }
      local python = vim.fs.joinpath(config.root_dir, unpack(executable))
      if vim.fn.executable(python) == 1 then
        config.settings = config.settings or {}
        config.settings.python = config.settings.python or {}
        config.settings.python.pythonPath = python
      end
    end,
  }
  vim.lsp.enable('pyright')

  -- Ruby (gem install ruby-lsp)
  vim.lsp.config.ruby_lsp = {
    cmd = { 'ruby-lsp' },
  }
  vim.lsp.enable('ruby_lsp')
end
