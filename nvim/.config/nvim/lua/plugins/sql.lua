return {
  { 'tpope/vim-dadbod' },
  { 'kristijanhusak/vim-dadbod-completion' },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      'tpope/vim-dadbod',
      'kristijanhusak/vim-dadbod-completion',
    },
    cmd = { 'DBUI', 'DBUIExecuteQuery', 'DBUIFindBuffer', 'DBUIRenameBuffer' },
    keys = {
      { '<leader>Db', '<cmd>DBUI<CR>', desc = 'Database UI' },
      { '<leader>Dq', '<cmd>DBUIExecuteQuery<CR>', desc = 'Database execute query' },
    },
  },
}
