local js_based_languages = {
  'typescript',
  'javascript',
  'typescriptreact',
  'javascriptreact',
}

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'microsoft/vscode-js-debug',
    {
      'mxsdev/nvim-dap-vscode-js',
      config = function()
        require('dap-vscode-js').setup {
          debugger_path = '/usr/lib/js-debug',
          adapters = { 'chrome', 'pwa-node', 'pwa-chrome' },
        }
      end,
    },
  },
  keys = {
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
  },
  config = function()
    for _, lang in ipairs(js_based_languages) do
      require('dap').configurations[lang] = {
        {
          type = 'pwa-node',
          request = 'launch',
          program = '${file}',
          name = 'Launch File',
        },
      }
    end
  end,
}

