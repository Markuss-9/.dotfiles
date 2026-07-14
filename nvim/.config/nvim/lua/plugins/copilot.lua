return {
  'zbirenbaum/copilot.lua',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      panel = { enabled = false },
      suggestion = {
        enabled = true,
        auto_trigger = false, -- disabled by default; toggle with <leader>og
        keymap = {
          accept = '<M-l>',
          accept_word = '<M-w>',
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<M-e>',
        },
      },
      filetypes = {
        ['*'] = true,
      },
    }

    vim.keymap.set('n', '<leader>og', function()
      require('copilot.suggestion').toggle_auto_trigger()
    end, { desc = 'Toggle Copilot ghost text' })
  end,
}
