return {
  'NMAC427/guess-indent.nvim',
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()

      local commentApi = require 'Comment.api'

      vim.keymap.set('n', '<C-_>', commentApi.toggle.linewise.current, { noremap = true, silent = true })
      vim.keymap.set('x', '<C-_>', function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<ESC>', true, false, true), 'nx', false)
        commentApi.toggle.linewise(vim.fn.visualmode())
      end, { noremap = true, silent = true })
      vim.keymap.set('n', '<C-/>', commentApi.toggle.linewise.current, { noremap = true, silent = true })
      vim.keymap.set('x', '<C-/>', function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<ESC>', true, false, true), 'nx', false)
        commentApi.toggle.linewise(vim.fn.visualmode())
      end, { noremap = true, silent = true })
    end,
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      },
    },
  },
}
