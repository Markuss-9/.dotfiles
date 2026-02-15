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
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Write (save)' })
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<CR>', { desc = 'Go to the previous buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>bnext<CR>', { desc = 'Go to the next buffer' })
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
