local keybindings = {
        [''] = {
        {
            key = 'è',
            cmd = 'HopWord',
        },
        {
            key = 'È',
            cmd = 'HopWordMW',
        },
        {
            key = '<leader>he',
            lua = "require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END, hint_offset = 1})",
        },
        {
            key = '<leader>hE',
            lua =
            "require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END, hint_offset = 1, mult_windows = true})",
        },
        {
            key = '<leader>hl',
            cmd = 'HopLineStart',
        },
        {
            key = '<leader>hL',
            cmd = 'HopLineStartMW',
        },
        {
            key = '<leader>hs',
            cmd = 'HopPattern',
        },
        {
            key = '<leader>hS',
            cmd = 'HopPatternMW',
        },
        {
            key = '<leader>hc',
            cmd = 'HopChar1',
        },
        {
            key = '<leader>hC',
            cmd = 'HopChar1MW',
        },
        {
            key = 'f',
            lua =
            "require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })",
        },
        {
            key = 'F',
            lua =
            "require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })",
        },
        {
            key = 'à',
            lua =
            "require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })",
        },
        {
            key = 'À',
            lua =
            "require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = -1 })",
        },
    },
}

for mode, bindings in pairs(keybindings) do
    for _, binding in ipairs(bindings) do
        local lhs = binding.key
        local rhs

        if binding.cmd ~= nil then
            rhs = '<cmd>' .. binding.cmd .. '<cr>'
        elseif binding.lua ~= nil then
            local t = type(binding.lua)
            if t == 'string' then
                rhs = ':lua ' .. binding.lua .. '<cr>'
            elseif t == 'function' then
                rhs = binding.lua
            end
        end

        vim.keymap.set(mode, lhs, rhs, { silent = true, noremap = true })
    end
end

