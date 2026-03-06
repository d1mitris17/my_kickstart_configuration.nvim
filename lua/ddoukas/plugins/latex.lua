return {
  'lervag/vimtex',
  ft = 'tex',
  config = function()
    -- Compile and view settings
    vim.g.vimtex_view_method = 'skim' -- macOS default PDF viewer
    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_quickfix_mode = 0

    -- Optional: leader shortcuts if you like
    -- \ll  → compile continuously
    -- \lv  → open PDF viewer
    -- \lk  → stop compiler
  end,
}
