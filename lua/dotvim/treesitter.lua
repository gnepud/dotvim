return function()
  local treesitter = require('nvim-treesitter')
  treesitter.install {
    "c", "lua", "vim", "vimdoc", "query", "comment", "ruby", "python",
    "javascript", "typescript", "json", "css", "scss", "html", "markdown"
  }
  vim.treesitter.language.register('javascript', 'javascriptreact')

  local group = vim.api.nvim_create_augroup('TreesitterHighlight', { clear = true })
  vim.api.nvim_create_autocmd('FileType', {
    group = group,
    pattern = {
      "c", "lua", "vim", "help", "query", "ruby", "python", "javascript",
      "javascriptreact", "typescript", "json", "css", "scss", "html", "markdown"
    },
    callback = function(event)
      -- Installation is asynchronous; skip buffers whose parser is not ready yet.
      local lang = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)
      if lang and vim.treesitter.get_parser(event.buf, lang) then
        vim.treesitter.start(event.buf, lang)
      end
    end,
  })
end
