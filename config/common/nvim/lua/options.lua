local o = vim.o
-- local wo = vim.wo
-- local bo = vim.bo

-- GLOBAL OPTIONS
-- o.debug = 'throw'
o.updatetime = 300
o.foldlevelstart = 99
o.termguicolors = true
o.mouse= 'a' -- Enable mouse
o.ignorecase = true -- Ignore case
o.confirm = true -- Disable 'no write'
o.scrolloff = 8 -- Lines from the cursor
o.incsearch = true -- Move cursor during search
o.splitright = true -- Splits open on the right
o.splitbelow = true -- Splits open on the bottom
o.wildmenu = true -- Command line completion mode
o.wildmode = 'full' -- Command line completion mode
o.hlsearch = true -- Highlight search results (enforce)
o.showmatch = true -- Show matching brackets/parenthesis
o.showmode = false -- Do not output message on the bottom
o.inccommand = 'split' -- Show effects of command as you type in a split
o.clipboard = 'unnamedplus' -- Use system clipboard
o.shortmess = vim.o.shortmess .. 'c'
o.guifont = 'monospace:h15'

local function setl(opt, value)
  vim.cmd(":set "..opt..(value and "="..value or ""))
end

-- BUFFER_OPTIONS
setl('expandtab')
setl('shiftwidth', 4)
setl('tabstop', 4)
setl('formatoptions', 'tqj')
setl('smartindent')

-- WINDOW_OPTIONS
setl('relativenumber')
setl('cursorline')
setl('linebreak')
setl('foldmethod', 'expr')
setl('foldexpr', 'nvim_treesitter#foldexpr()')
setl('signcolumn', 'yes')
