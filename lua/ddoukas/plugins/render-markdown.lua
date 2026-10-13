return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = { 'markdown' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '<leader>tm', '<Cmd>RenderMarkdown toggle<CR>', desc = 'Toggle [M]arkdown render' },
  },
  -- latex.enabled/inline/block are already true by default; converter falls
  -- through its default list to 'latex2text' (from `pip3 install --user pylatexenc`)
  opts = {},
}
