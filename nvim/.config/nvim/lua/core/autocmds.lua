vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'TermClose', 'TermLeave' }, {
  desc = 'Reload file when changed externally',
  group = vim.api.nvim_create_augroup('autoread', { clear = true }),
  callback = function()
    if vim.fn.mode() ~= 'c' then
      vim.cmd 'checktime'
    end
  end,
})

local function set_diff_highlights()
  local diff_colors = {
    add_line = '#1b2f24',
    delete_line = '#332027',
    change_line = '#27283a',
    add_text = '#2f6f45',
    delete_text = '#7a2f3a',
    change_text = '#3f4f8f',
  }

  local highlights = {
    DiffAdd = { bg = diff_colors.add_line },
    DiffDelete = { bg = diff_colors.delete_line },
    DiffChange = { bg = diff_colors.change_line },
    DiffText = { bg = diff_colors.change_text, bold = true },
    DiffviewDiffAdd = { bg = diff_colors.add_line },
    DiffviewDiffDelete = { bg = diff_colors.delete_line },
    DiffviewDiffAddAsDelete = { bg = diff_colors.delete_line },
    DiffviewDiffChange = { bg = diff_colors.change_line },
    DiffviewDiffText = { bg = diff_colors.change_text, bold = true },
    DiffviewDiffAddText = { bg = diff_colors.add_text, bold = true },
    DiffviewDiffDeleteText = { bg = diff_colors.delete_text, bold = true },
  }

  for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

local function set_diffview_inline_highlights()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local winhl = vim.wo[win].winhighlight

    if winhl:find('DiffAdd:DiffviewDiffAddAsDelete', 1, true) then
      vim.wo[win].winhighlight = winhl:gsub('DiffText:DiffviewDiffText', 'DiffText:DiffviewDiffDeleteText')
    elseif winhl:find('DiffAdd:DiffviewDiffAdd', 1, true) then
      vim.wo[win].winhighlight = winhl:gsub('DiffText:DiffviewDiffText', 'DiffText:DiffviewDiffAddText')
    end
  end
end

vim.api.nvim_create_autocmd('ColorScheme', {
  desc = 'Use stronger full-line diff backgrounds',
  group = vim.api.nvim_create_augroup('diff-highlights', { clear = true }),
  callback = set_diff_highlights,
})

set_diff_highlights()

vim.api.nvim_create_autocmd('User', {
  desc = 'Use add/delete colors for Diffview inline text changes',
  group = vim.api.nvim_create_augroup('diffview-inline-highlights', { clear = true }),
  pattern = 'DiffviewViewPostLayout',
  callback = set_diffview_inline_highlights,
})
