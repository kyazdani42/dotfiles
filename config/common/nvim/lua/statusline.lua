local api = vim.api

local M = {}

local Colors = {
  ['STNormalFlatMD'] = { guifg= '#32374d', guibg='#1b1e2b'},
  ['STNormalFlatInfo'] = { guifg= '#32374d', guibg='#1b1e2b'},

  ['STNormalMD'] = { guifg= '#ffffff', guibg='#292d3e'},
  ['STVisualMD'] = { guibg = '#89bbdd', guifg = '#292d3e' },
  ['STInsertMD'] = { guibg = '#b9a3eb', guifg='#292d3e' },
  ['STReplaceMD'] = { guibg = '#d0e7d0', guifg='#292d3e' },
  ['STTermMD'] = { guibg = '#959dcb', guifg='#292d3e' },

  ['STNormalInfo'] = { guifg= '#ffffff', guibg='#1b1e2b'},
  ['STVisualInfo'] = { guifg = '#89bbdd', guibg='#1b1e2b' },
  ['STInsertInfo'] = { guifg = '#b9a3eb', guibg='#1b1e2b' },
  ['STReplaceInfo'] = { guifg = '#d0e7d0', guibg='#1b1e2b' },
  ['STTermInfo'] = { guifg = '#959dcb', guibg='#1b1e2b' },
}

local Modes = {
  ['n']   = { color = '%#STNormalMD#', val = ' NORMAL ' },
  ['no']  = { color = '%#STNormalMD#', val = ' N-Operator Pending ' },

  ['v']   = { color = '%#STVisualMD#', val = ' VISUAL ' },
  ['V']   = { color = '%#STVisualMD#', val = ' V-LINE ' },
  ['\22'] = { color = '%#STVisualMD#', val = ' V-BLOCK ' },

  ['i']   = { color = '%#STInsertMD#', val = ' INSERT ' },
  ['ic']  = { color = '%#STInsertMD#', val = ' INSERT ' },
  ['ix']  = { color = '%#STInsertMD#', val = ' INSERT ' },

  ['R']   = { color = '%#STReplaceMD#', val = ' REPLACE ' },
  ['Rv']  = { color = '%#STReplaceMD#', val = ' V-REPLACE ' },

  ['t']   = { color = '%#STTermMD#', val = ' TERMINAL ' },

  ['s']   = { color = '%#STNormalFlatMD#', val = ' SELECT ' },
  ['S']   = { color = '%#STNormalFlatMD#', val = ' S-LINE ' },
  ['^S']  = { color = '%#STNormalFlatMD#', val = ' S-BLOCK ' },
  ['c']   = { color = '%#STNormalFlatMD#', val = ' COMMAND ' },
  ['cv']  = { color = '%#STNormalFlatMD#', val = ' VIM EX ' },
  ['ce']  = { color = '%#STNormalFlatMD#', val = ' EX ' },
  ['r']   = { color = '%#STNormalFlatMD#', val = ' PROMPT ' },
  ['rm']  = { color = '%#STNormalFlatMD#', val = ' MORE ' },
  ['r?']  = { color = '%#STNormalFlatMD#', val = ' CONFIRM ' },
  ['!']   = { color = '%#STNormalFlatMD#', val = ' SHELL ' },
}

local function get_mode(bufnr)
  local mode = api.nvim_get_mode().mode
  return Modes[mode] or { val = 'Unknown mode: ', color = '%#CursorLine#' }
end

local branch = vim.fn.system('git rev-parse --abbrev-ref HEAD'):sub(0, -2)
local is_git = branch:match('fatal') == nil

local function get_git(bufnr)
  if is_git then
    return branch .. ' |'
  else
    return ''
  end
end

local function get_infos(bufnr)
  local ft = api.nvim_buf_get_option(bufnr, 'ft')
  if ft ~= '' then ft = ' '..ft..' |' end

  local _, row, col = unpack(vim.fn.getpos('.'))
  local num_lines = #api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local percent = string.format('%d', row / num_lines * 100) .. '%%'

  return string.format('%s %s:%s | %s | %s ', ft, row, col, percent, num_lines)
end

local function get_filename(bufnr)
  local fname = api.nvim_buf_get_name(bufnr)
  if #fname == 0 then
    return '[NO NAME]'
  end

  local icon = ''
  if vim.fn.exists('*WebDevIconsGetFileTypeSymbol') == 1 then
    local icon = api.nvim_call_function('WebDevIconsGetFileTypeSymbol', { fname, false })
  end

  fname = vim.fn.fnamemodify(fname, ':~')

  return icon..fname
end

function M.clear()
  local bufnr = api.nvim_get_current_buf()
  for _, win in ipairs(api.nvim_list_wins()) do
    local wbufnr =  api.nvim_win_get_buf(win)
    if wbufnr ~= bufnr then
      api.nvim_win_set_option(win, 'statusline', '%#VertSplit#'..string.rep('―', api.nvim_win_get_width(win)))
    end
  end
end

local function format_status(mode, filename, git, infos)
  local left_side = mode.color..mode.val..'%#Normal# '..filename
  local right_side =mode.color:gsub('MD', 'Info')..git..infos..'%#Normal#'
  local total_size = api.nvim_win_get_width(0)

  local padding = ' '
  local padding = padding:rep(total_size - (#mode.val + #filename + #git + #infos + 1))

  return left_side..padding..right_side
end

function M.update()
  local bufnr = api.nvim_get_current_buf()
  if api.nvim_buf_get_option(bufnr, 'ft') == 'LuaTree' then return ' ' end
  local win = api.nvim_get_current_win()

  local mode = get_mode(bufnr)
  local filename = get_filename(bufnr)
  local git = get_git(bufnr)
  local infos = get_infos(bufnr)

  local formatted_status = format_status(mode, filename, git, infos)

  return formatted_status
end

function M.setup()
  local func = [[
  function! Status()
    return luaeval("require 'statusline'.update()")
  endfunction

  augroup StatusLine
    au!
    au BufEnter,WinEnter,VimEnter * lua require'statusline'.clear()
    au BufEnter,CursorMoved,CursorMovedI,WinEnter,CompleteDone,InsertEnter,InsertLeave * setlocal statusline=%!Status()
  augroup END
  ]]
  api.nvim_exec(func, '')

  for name, c in pairs(Colors) do
    api.nvim_command('hi def '..name..' gui=NONE guifg='..c.guifg..' guibg='..c.guibg)
  end
end

return M
