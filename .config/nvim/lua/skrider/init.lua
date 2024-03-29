require("skrider.set")
require("skrider.remap")

local augroup = vim.api.nvim_create_augroup

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

vim.cmd [[ 
    set autoread
    au CursorHold * checktime
]]

-- set wrap in markdown files
autocmd('BufEnter', {
    group = augroup('markdown_wrap', {}),
    pattern = '*.md',
    callback = function()
        vim.cmd('setlocal wrap!')
    end,
})

autocmd({'InsertEnter', 'InsertLeave'}, {
    group = augroup('disable_wrap', {}),
    pattern = '*',
    callback = function()
        vim.cmd('setlocal relativenumber!')
    end,
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

vim.api.nvim_exec([[
  autocmd BufRead,BufNewFile *.hcl set filetype=tf
]], false)

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.api.nvim_exec([[
  autocmd FileType c setlocal tabstop=2 shiftwidth=2 expandtab
]], false)

require("skrider.packer")



