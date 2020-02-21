local api = vim.api

local OPTIONS = {
    termguicolors = true,
    background = 'dark',
    t_Co = '256'
}

local DARK_BLUE = '#1c1f2b'
local SEARCH_BG = '#39446c'
local SELECTION = '#343a51'
local LINE_NBR = '#3a3f58'
local CYAN = '#89ddff'
local PURPLE = '#c792ea'
local FG = '#959dcb'
local WHITE = '#ffffff'

local HIGHLIGHT_GROUPS = {
    Pmenu = { bg = DARK_BLUE, fg = WHITE },                   -- normal item popup
    PmenuSel = { bg = PURPLE, fg = WHITE, gui = 'bold' },     -- selected item popup
    PmenuSbar = { bg = FG, fg = FG },                         -- scrollbar popup
    PmenuThumb = { bg = SEARCH_BG, fg = SEARCH_BG },          -- scrollbar thumb popup
    CursorLine = { bg = DARK_BLUE },                          -- current line
    LineNr = { fg = LINE_NBR },                               -- line numbers
    Visual = { bg = SELECTION },                              -- selection
    VisualNOS = { bg = SELECTION },                           -- selection not owned by vim
    Search = { bg = SEARCH_BG, fg = 'default' },              -- search results
    IncSearch = { bg = SEARCH_BG, fg= 'default' },            -- while typing search
    EndOfBuffer = { bg = 'bg', fg = 'bg' },                   -- little ~
    MatchParen = { gui = 'bold', fg = CYAN, bg = 'default' }, -- matching paren
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
