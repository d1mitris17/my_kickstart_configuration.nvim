return {
  'christoomey/vim-tmux-navigator',
  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
    'TmuxNavigatePrevious',
  },
  init = function()
    -- We define our own keymaps below, so skip the plugin's default ones.
    vim.g.tmux_navigator_no_mappings = 1
  end,
  keys = {
    { '<C-h>', '<Cmd>TmuxNavigateLeft<CR>', desc = 'Move focus to the left window/pane' },
    { '<C-l>', '<Cmd>TmuxNavigateRight<CR>', desc = 'Move focus to the right window/pane' },
    { '<C-j>', '<Cmd>TmuxNavigateDown<CR>', desc = 'Move focus to the lower window/pane' },
    { '<C-k>', '<Cmd>TmuxNavigateUp<CR>', desc = 'Move focus to the upper window/pane' },
  },
}
