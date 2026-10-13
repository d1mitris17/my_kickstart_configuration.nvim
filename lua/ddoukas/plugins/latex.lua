return {
  'lervag/vimtex',
  ft = 'tex',
  config = function()
    -- Compile and view settings
    -- zathura_simple: plain zathura needs xdotool, which doesn't work under sway
    vim.g.vimtex_view_method = vim.fn.has 'mac' == 1 and 'skim' or 'zathura_simple'
    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_quickfix_mode = 0

    -- Optional: leader shortcuts if you like
    -- \ll  → compile continuously
    -- \lv  → open PDF viewer
    -- \lk  → stop compiler
  end,
}
