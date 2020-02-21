local api = vim.api

local OPTIONS = {
    termguicolors = true,
    background = 'dark',
    t_Co = '256'
}

local HIGHLIGHT_GROUPS = {
    CursorLine = { bg = '#1c1f2b' },
    LineNr = { fg = '#3a3f58' },
    Visual = { bg = '#343a51' },
    VisualNOS = { bg = '#343a51' },
    Search = { bg = '#4c4b65', fg = 'default' },
    IncSearch = { bg = '#4c4b65', fg= 'default' },
    MatchParen = { gui = 'bold,underline', fg = '#a77eca', bg = 'default' },
    EndOfBuffer = { bg = '#292d3e', fg = 'bg' }
}

local function set_highlights()
    for group, data in pairs(HIGHLIGHT_GROUPS) do
        local fg = data.fg and " guifg=".. data.fg or ""
        local bg = data.bg and " guibg=".. data.bg or ""
        local gui = data.gui and " gui=".. data.gui or ""
        api.nvim_command('hi ' .. group .. gui .. bg .. fg)
    end
end

local function init_setup()
    for opt, val in pairs(OPTIONS) do
        api.nvim_set_option(opt, val)
    end
    api.nvim_command('let $NVIM_TUI_ENABLE_TRUE_COLOR=1')
    api.nvim_command('syntax on')
    api.nvim_set_var('palenight_terminal_italics', 1)
    api.nvim_command('silent! colorscheme palenight')
end

local function setup()
    init_setup()
    set_highlights()
end

return {
    setup = setup
}
