local config_dir = vim.fn.stdpath('config')
local root = config_dir .. '/.lazy'
local lazypath = root .. '/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local output = vim.fn.system({
    'git', 'clone', '--filter=blob:none', '--branch=stable',
    'https://github.com/folke/lazy.nvim.git', lazypath,
  })
  if vim.v.shell_error ~= 0 then
    error('Failed to install lazy.nvim: ' .. output)
  end
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup(require('dotvim.plugins'), {
  root = root,
  lockfile = config_dir .. '/lazy-lock.json',
  defaults = { lazy = false },
  checker = { enabled = false },
  change_detection = { notify = false },
  rocks = { enabled = false },
})
