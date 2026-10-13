return {
  {
    -- Only used for ftdetect, syntax, indent, ftplugin (path/includeexpr/tagfunc);
    -- vsrocq.nvim does the proving. Coqtail never spawns coqtop unless you :RocqStart.
    -- NOTE: the README's `loaded_coqtail = 1` trick breaks current Coqtail, whose
    -- ftplugin requires g:coqtail_supported (set by its plugin/ script).
    'whonore/Coqtail',
    init = function()
      vim.g.coqtail_nomap = 1
    end,
  },
  {
    'tomtomjhj/vsrocq.nvim',
    ft = 'coq',
    dependencies = {
      'whonore/Coqtail',
    },
    opts = {
      vsrocq = {
        completion = {
          enable = true,
        },
        proof = {
          mode = 'Continuous',
        },
      },
      lsp = {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        on_attach = function(_, bufnr)
          local function map(keys, cmd, desc)
            vim.keymap.set('n', keys, cmd, { buffer = bufnr, desc = desc })
          end

          map('<leader>cvj', '<Cmd>VsRocq stepForward<CR>', 'Step forward')
          map('<leader>cvk', '<Cmd>VsRocq stepBackward<CR>', 'Step backward')
          map('<leader>cvl', '<Cmd>VsRocq interpretToPoint<CR>', 'Interpret to point')
          map('<leader>cvL', '<Cmd>VsRocq interpretToEnd<CR>', 'Interpret to end')
          map('<leader>cvG', '<Cmd>VsRocq jumpToEnd<CR>', 'Jump to end')

          map('<leader>cvm', '<Cmd>VsRocq manual<CR>', 'Manual mode')
          map('<leader>cvc', '<Cmd>VsRocq continuous<CR>', 'Continuous mode')

          map('<leader>cvp', '<Cmd>VsRocq panels<CR>', 'Open panels')
          map('<leader>cvg', '<Cmd>VsRocq goals<CR>', 'Goals')
          map('<leader>cva', '<Cmd>VsRocq admitted<CR>', 'Admitted goals')
          map('<leader>cvs', '<Cmd>VsRocq shelved<CR>', 'Shelved goals')

          map('<leader>cvqc', ':VsRocq check ', 'Query: check')
          map('<leader>cvqa', ':VsRocq about ', 'Query: about')
          map('<leader>cvqp', ':VsRocq print ', 'Query: print')
          map('<leader>cvql', ':VsRocq locate ', 'Query: locate')
          map('<leader>cvqs', ':VsRocq search ', 'Query: search')
        end,
      },
    },
  },
}
