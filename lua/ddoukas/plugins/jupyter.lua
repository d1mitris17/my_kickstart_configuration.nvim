-- Jupyter notebooks in Neovim:
--   jupytext.nvim          .ipynb <-> plain python with `# %%` cell markers, converted back on save
--   molten-nvim            runs code against a real Jupyter kernel, output shown under the cell
--   NotebookNavigator.nvim `# %%` cell-aware motions and run-cell-under-cursor

local is_mac = vim.fn.has 'mac' == 1
-- On Linux, bootstrap-ubuntu.sh creates ~/.virtualenvs/neovim with pynvim +
-- jupyter_client and registers it as the `python3` kernel.
local host_python = is_mac and '/Library/Frameworks/Python.framework/Versions/3.11/bin/python3'
  or vim.fn.expand '~/.virtualenvs/neovim/bin/python3'
local kernel = is_mac and 'python311' or 'python3'

return {
  {
    'GCBallesteros/jupytext.nvim',
    -- Not lazy: it registers a BufReadCmd handler, which has to exist before
    -- the first .ipynb buffer is read (e.g. `nvim foo.ipynb`).
    lazy = false,
    opts = {
      style = 'hydrogen', -- percent format, i.e. `# %%` cell markers
      output_extension = 'auto',
      force_ft = nil,
    },
  },

  {
    'benlubas/molten-nvim',
    build = ':UpdateRemotePlugins',
    init = function()
      -- pynvim + jupyter_client live in this interpreter
      vim.g.python3_host_prog = host_python

      -- Alacritty implements no inline image protocol, so plots can't render in
      -- the buffer; :MoltenImagePopup opens them in an external viewer instead.
      vim.g.molten_image_provider = 'none'

      vim.g.molten_virt_text_output = true -- output as virtual text under the cell
      vim.g.molten_auto_open_output = false -- ...rather than a floating window
      vim.g.molten_wrap_output = true
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_virt_lines_off_by_1 = true
    end,
    keys = {
      { '<leader>ji', '<Cmd>MoltenInit ' .. kernel .. '<CR>', desc = 'Molten [i]nit kernel' },
      { '<leader>jl', '<Cmd>MoltenEvaluateLine<CR>', desc = 'Molten evaluate [l]ine' },
      { '<leader>je', '<Cmd>MoltenEvaluateOperator<CR>', desc = 'Molten [e]valuate operator' },
      { '<leader>jv', ':<C-u>MoltenEvaluateVisual<CR>gv', mode = 'v', desc = 'Molten evaluate [v]isual' },
      { '<leader>jr', '<Cmd>MoltenReevaluateCell<CR>', desc = 'Molten [r]e-evaluate cell' },
      { '<leader>jo', '<Cmd>MoltenShowOutput<CR>', desc = 'Molten show [o]utput' },
      { '<leader>jh', '<Cmd>MoltenHideOutput<CR>', desc = 'Molten [h]ide output' },
      { '<leader>jd', '<Cmd>MoltenDelete<CR>', desc = 'Molten [d]elete cell' },
      { '<leader>jp', '<Cmd>MoltenImagePopup<CR>', desc = 'Molten image [p]opup' },
    },
  },

  {
    'GCBallesteros/NotebookNavigator.nvim',
    dependencies = {
      'echasnovski/mini.nvim', -- supplies mini.comment for comment_cell
      'benlubas/molten-nvim',
    },
    event = 'VeryLazy',
    keys = {
      {
        ']h',
        function()
          require('notebook-navigator').move_cell 'd'
        end,
        desc = 'Next cell',
      },
      {
        '[h',
        function()
          require('notebook-navigator').move_cell 'u'
        end,
        desc = 'Previous cell',
      },
      {
        '<leader>x',
        function()
          require('notebook-navigator').run_and_move()
        end,
        desc = 'Run cell and move',
      },
      {
        '<leader>X',
        function()
          require('notebook-navigator').run_cell()
        end,
        desc = 'Run cell',
      },
    },
    opts = {
      repl_provider = 'auto', -- picks up molten-nvim
      cell_markers = { python = '# %%' },
    },
  },
}
