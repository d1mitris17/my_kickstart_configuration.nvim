-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  init = function()
    -- Without this, `nvim .` / `nvim <dir>` falls through to netrw instead of
    -- Neo-tree, since Neo-tree is otherwise only lazy-loaded via cmd/keys and
    -- never gets a chance to take over before netrw does.
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        local stats = vim.uv.fs_stat(vim.fn.argv(0) --[[@as string]])
        if stats and stats.type == 'directory' then
          require 'neo-tree'
        end
      end,
    })
  end,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>e', ':Neotree toggle<CR>', desc = '[E]xplorer', silent = true },
  },
  opts = {
    source_selector = {
      winbar = true,
      statusline = false,
    },
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
