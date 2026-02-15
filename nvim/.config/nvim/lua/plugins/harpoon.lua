return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    local mark = harpoon:list()
    local ui = harpoon.ui

    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = 'Add current file to Harpoon' })

    vim.keymap.set('n', '<leader>ho', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Toggle Harpoon quick menu' })

    vim.keymap.set('n', '<leader>1', function()
      harpoon:list():select(1)
    end, { desc = 'Navigate to Harpoon file 1' })

    vim.keymap.set('n', '<leader>2', function()
      harpoon:list():select(2)
    end, { desc = 'Navigate to Harpoon file 2' })

    vim.keymap.set('n', '<leader>3', function()
      harpoon:list():select(3)
    end, { desc = 'Navigate to Harpoon file 3' })

    vim.keymap.set('n', '<leader>4', function()
      harpoon:list():select(4)
    end, { desc = 'Navigate to Harpoon file 4' })

    vim.keymap.set('n', '<leader>5', function()
      harpoon:list():select(5)
    end, { desc = 'Navigate to Harpoon file 5' })

    vim.keymap.set('n', '<C-Left', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', '<C-Right>', function()
      harpoon:list():next()
    end)


    -- for i = 1, 9 do
    --   vim.keymap.set('n', '<leader>fh' .. i, function()
    --     mark:select(i)
    --   end, { desc = 'File ' .. i })
    -- end

    vim.keymap.set('n', '<leader>fhr', function()
      local buf_name = vim.fn.fnamemodify(vim.fn.expand '%:p', ':~:.')
      local found = false

      for index, entry in ipairs(mark.items) do
        if entry.value == buf_name then
          table.remove(mark.items, index)
          mark._length = mark._length - 1
          found = true
          print('Removed from Harpoon: ' .. buf_name)
          break
        end
      end

      if not found then
        print 'File not found in Harpoon list'
      end
    end, { desc = 'Remove Current File' })

    vim.keymap.set('n', '<leader>hc', function()
      for index = #mark.items, 1, -1 do
        table.remove(mark.items, index)
      end
      print 'Cleared all marks'
    end, { desc = 'Clear All Marks' })

    vim.keymap.set('n', '<leader>fhp', function()
      mark:prev()
    end, { desc = 'Previous Buffer' })
    vim.keymap.set('n', '<leader>fhn', function()
      mark:next()
    end, { desc = 'Next Buffer' })
  end,
}
