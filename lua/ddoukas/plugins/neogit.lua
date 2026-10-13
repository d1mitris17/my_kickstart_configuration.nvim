-- Neogit: Magit-style git interface.
-- diffview.nvim handles merge conflicts with a 3-way view (ours | result | theirs).
--
-- Resolving conflicts:
--   <leader>gc opens the merge tool; jump between conflicts with ]x / [x
--   <leader>co / <leader>ct / <leader>cb / <leader>ca  choose ours / theirs / base / all
--   dx deletes the conflict region; when done, stage the file and close with <leader>gq
return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    cmd = 'Neogit',
    opts = {
      integrations = {
        diffview = true,
        telescope = true,
      },
    },
    keys = {
      { '<leader>gg', '<Cmd>Neogit<CR>', desc = 'Neo[g]it status' },
      { '<leader>gl', '<Cmd>Neogit log<CR>', desc = 'Neogit [l]og' },
    },
  },
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
    opts = {
      view = {
        merge_tool = {
          layout = 'diff3_mixed',
        },
      },
    },
    keys = {
      { '<leader>gc', '<Cmd>DiffviewOpen<CR>', desc = '[c]onflicts / diff view' },
      { '<leader>gh', '<Cmd>DiffviewFileHistory %<CR>', desc = 'File [h]istory' },
      { '<leader>gq', '<Cmd>DiffviewClose<CR>', desc = '[q]uit diff view' },
    },
  },
}
