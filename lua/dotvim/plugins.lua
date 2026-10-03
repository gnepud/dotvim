return {
  {
    'preservim/nerdtree',
    cmd = 'NERDTreeToggle',
    keys = {
      {
        '<Leader>n', ':NERDTreeToggle<CR>',
        mode = { 'n', 'x', 's', 'o' },
        remap = true,
        desc = 'Toggle NERDTree',
      },
    },
    init = function()
      vim.g.NERDTreeMinimalUI = 1
      vim.g.NERDTreeAutoDeleteBuffer = 1
    end,
    config = function()
      -- Close the tab when its only remaining window is the tab's NERDTree.
      local group = vim.api.nvim_create_augroup('NERDTree', { clear = true })
      vim.api.nvim_create_autocmd('BufEnter', {
        group = group,
        callback = function()
          local tree = vim.b.NERDTree
          -- NERDTree's isTabTree() checks this same field.
          if vim.fn.winnr('$') == 1 and tree and tree._type == 'tab' then
            vim.cmd.quit()
          end
        end,
      })
    end,
  },
  { 'tpope/vim-fugitive' },
  { 'junegunn/gv.vim', dependencies = { 'tpope/vim-fugitive' } },
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    keys = require('dotvim.gitsigns'),
    opts = {},
  },
  {
    'junegunn/vim-easy-align',
    lazy = false,
    keys = {
      { 'ga', '<Plug>(EasyAlign)', mode = { 'n', 'x' }, remap = true, desc = 'EasyAlign' },
    },
  },
  {
    'junegunn/fzf',
    build = function() vim.fn['fzf#install']() end,
  },
  {
    'junegunn/fzf.vim',
    lazy = false,
    dependencies = { 'junegunn/fzf' },
    keys = {
      { '<Leader>f', ':Files<CR>', remap = true, desc = 'Find files' },
      { '<Leader>F', ':Rg<CR>', remap = true, desc = 'Search text' },
    },
    init = function()
      vim.g.fzf_preview_window = { 'down,60%', 'ctrl-/' }
      vim.g.fzf_layout = { window = { width = 0.8, height = 0.9 } }
    end,
  },
  { 'mg979/vim-visual-multi' },
  { 'windwp/nvim-autopairs', opts = {} },
  {
    'sainnhe/sonokai',
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.sonokai_better_performance = 1
      vim.g.sonokai_enable_italic = 0
      vim.g.sonokai_disable_italic_comment = 1
    end,
    config = function() vim.cmd.colorscheme('sonokai') end,
  },
  { 'sainnhe/edge' },
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = require('dotvim.treesitter'),
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = require('dotvim.treesitter_context'),
  },
  { 'kylechui/nvim-surround', opts = {} },
  { 'neovim/nvim-lspconfig', config = require('dotvim.lsp') },
}
