-- Command for running Jupyter QtConsole
vim.cmd [[
  command! -nargs=0 RunQtConsole call jobstart("jupyter qtconsole --JupyterWidget.include_other_output=True")
]]

vim.cmd [[
  command! -nargs=0 RunExistingQtConsole call jobstart("jupyter qtconsole --JupyterWidget.include_other_output=True --existing")
]]

-- Set cell definition regex
vim.g.ipy_celldef = '^#\\s%%'

-- Key mappings
vim.api.nvim_set_keymap('n', '<leader>jqt', ':RunQtConsole<Enter>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>jqe', ':RunExistingQtConsole<Enter>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>jk', ':IPython --existing --no-window<Enter>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>jc', '<Plug>(IPy-RunCell)', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>jl', '<Plug>(IPy-Run)', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ja', '<Plug>(IPy-RunAll)', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>j?', '<Plug>(IPy-WordObjInfo)', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ji', '<Plug>(IPy-Interrupt)', {noremap = true, silent = true})
