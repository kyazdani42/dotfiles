local o = vim.o
local wo = vim.wo
local bo = vim.bo

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

function _G.set_buffer_options()
  local curbuf = vim.api.nvim_get_current_buf()
  bo[curbuf].expandtab = true
  bo[curbuf].shiftwidth = 4
  bo[curbuf].tabstop = 4
  bo[curbuf].formatoptions= 'tqj'
  bo[curbuf].smartindent = true
end

vim.cmd "au BufNew * lua set_buffer_options()"

function _G.set_window_option()
  local winnr = vim.api.nvim_get_current_win()
  local bufnr = vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  if bufname:match("NvimTree") or bufname:match("fzf") then
    return
  end
  wo[winnr].relativenumber = true
  wo[winnr].cursorline = true
  wo[winnr].linebreak = true
  wo[winnr].foldmethod = 'expr'
  wo[winnr].foldexpr = 'nvim_treesitter#foldexpr()'
  wo[winnr].signcolumn = 'yes'
end
set_window_option()

vim.cmd "au WinNew,VimEnter * lua vim.schedule(set_window_option)"
