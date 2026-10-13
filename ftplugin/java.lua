-- Run the current Java file in a terminal split.
--
-- Compiles into a temp dir with the package's source root on -sourcepath,
-- so classes the file uses from the same project are compiled too.
-- Works for plain/Eclipse-style projects; Maven/Gradle projects with
-- external dependencies should be run with mvn/gradle instead.
local function run_java_file()
  vim.cmd 'silent write'

  local file = vim.fn.expand '%:p'
  local class = vim.fn.expand '%:t:r'
  local src_root = vim.fn.expand '%:p:h'

  -- If the file declares a package, the source root is one dir up per package component
  for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, 50, false)) do
    local pkg = line:match '^%s*package%s+([%w_.]+)%s*;'
    if pkg then
      class = pkg .. '.' .. class
      for _ in pkg:gmatch '[^.]+' do
        src_root = vim.fn.fnamemodify(src_root, ':h')
      end
      break
    end
  end

  local out = vim.fn.tempname()
  local cmd = string.format(
    'javac -d %s -sourcepath %s %s && java -cp %s %s',
    vim.fn.shellescape(out),
    vim.fn.shellescape(src_root),
    vim.fn.shellescape(file),
    vim.fn.shellescape(out),
    class
  )

  vim.cmd 'botright 15new'
  vim.fn.jobstart(cmd, { term = true, cwd = src_root })
  vim.cmd 'startinsert' -- so programs reading stdin (e.g. Scanner) get input
end

vim.keymap.set('n', '<leader>cr', run_java_file, { buffer = true, desc = '[C]ode [R]un Java file' })
