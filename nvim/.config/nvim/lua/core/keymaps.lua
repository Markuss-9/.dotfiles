vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>d', function()
  vim.diagnostic.setloclist()
  vim.cmd 'lopen 5'
end, { desc = 'Open diagnostic Quickfix list' })
vim.keymap.set('n', '[p', function()
  vim.diagnostic.open_float()
end, { desc = 'Open diagnostic float', noremap = true, silent = true })
vim.keymap.set('n', ']p', function()
  vim.diagnostic.open_float()
  vim.diagnostic.open_float()
end, { desc = 'Open diagnostic float', noremap = true, silent = true })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>cq', function()
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 and win.loclist == 0 then
      vim.cmd 'cclose'
      return
    end
  end
  vim.cmd 'copen'
end, { desc = 'Toggle quickfix list' })
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Write (save)' })
vim.keymap.set('n', '<S-h>', '<C-o>', { desc = 'Go back in jump list' })
vim.keymap.set('n', '<S-l>', '<C-i>', { desc = 'Go forward in jump list' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
local fullscreen = false
function ToggleFullscreen()
  if not fullscreen then
    vim.cmd 'mksession! /tmp/nvim_fullscreen.vim'
    vim.cmd 'only'
    fullscreen = true
  else
    vim.cmd 'source /tmp/nvim_fullscreen.vim'
    fullscreen = false
  end
end
vim.keymap.set('n', '<leader>ff', ToggleFullscreen, { noremap = true, silent = true })

-- Map Oil to <leader>e
vim.keymap.set('n', '<leader>e', function()
  local ok_harpoon, harpoon = pcall(require, 'harpoon')
  if ok_harpoon and harpoon.ui and harpoon.ui.win_id and vim.api.nvim_win_is_valid(harpoon.ui.win_id) then
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end

  local ok, err = pcall(function()
    require('oil').toggle_float()
  end)

  if ok then
    return
  end

  if type(err) == 'string' and err:find('Window was closed immediately', 1, true) then
    vim.schedule(function()
      local ok_retry = pcall(function()
        require('oil').open_float()
      end)

      if not ok_retry then
        require('oil').open()
      end
    end)
    return
  end

  vim.notify(err, vim.log.levels.ERROR)
end, { desc = 'Toggle Oil file explorer' })

vim.keymap.set('n', '<leader>gr', function()
  vim.cmd 'checktime'
end, { desc = 'Reload file from disk' })
