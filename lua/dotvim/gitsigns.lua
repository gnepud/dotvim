local function action(name, ...)
  local args = { ... }
  return function()
    return require('gitsigns')[name](unpack(args))
  end
end

local function navigate(direction, fallback)
  return function()
    if vim.wo.diff then return fallback end
    vim.schedule(function() require('gitsigns').nav_hunk(direction) end)
    return '<Ignore>'
  end
end

return {
  { ']c', navigate('next', ']c'), expr = true, desc = 'Next Git hunk' },
  { '[c', navigate('prev', '[c'), expr = true, desc = 'Previous Git hunk' },
  { '<leader>hs', ':Gitsigns stage_hunk<CR>', mode = { 'n', 'v' }, desc = 'Stage hunk' },
  { '<leader>hr', ':Gitsigns reset_hunk<CR>', mode = { 'n', 'v' }, desc = 'Reset hunk' },
  { '<leader>hS', action('stage_buffer'), desc = 'Stage buffer' },
  { '<leader>hu', action('undo_stage_hunk'), desc = 'Undo last hunk staging' },
  { '<leader>hR', action('reset_buffer'), desc = 'Reset buffer' },
  { '<leader>hp', action('preview_hunk'), desc = 'Preview hunk' },
  { '<leader>hb', action('blame_line', { full = true }), desc = 'Blame line' },
  { '<leader>tb', action('toggle_current_line_blame'), desc = 'Toggle line blame' },
  { '<leader>hd', action('diffthis'), desc = 'Diff against index' },
  { '<leader>hD', action('diffthis', '~'), desc = 'Diff against previous revision' },
  { '<leader>td', action('toggle_deleted'), desc = 'Toggle deleted lines' },
  { 'ih', ':<C-U>Gitsigns select_hunk<CR>', mode = { 'o', 'x' }, desc = 'Git hunk text object' },
}
