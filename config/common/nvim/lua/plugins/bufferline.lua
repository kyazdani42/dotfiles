local options = {
  view = "default",
  numbers = "none",
  buffer_close_icon= '',
  modified_icon = '✗',
  close_icon = '',
  left_trunc_marker = '<',
  right_trunc_marker = '>',
  max_name_length = 18,
  max_prefix_length = 15,
  tab_size = 18,
  diagnostics = false,
  show_buffer_close_icons = false,
  persist_buffer_sort = true,
  enforce_regular_tabs = false,
  always_show_bufferline = true,
  sort_by = 'directory'
}

local bg_def = '#1b1e2b'
local bg_sel = '#121622'
local fg_def = '#a6accd'

local highlights =  {
  fill = {
    guifg = fg_def,
    guibg = bg_def
  },
  background = {
    guifg = fg_def,
    guibg = bg_def
  },
  buffer_visible = {
    guifg = fg_def,
    guibg = bg_def
  },
  buffer_selected = {
    guifg = 'normal_fg',
    guibg = bg_sel,
    gui = "bold"
  },
  modified = {
    guifg = '#df4344',
    guibg = bg_def
  },
  modified_visible = {
    guifg = '#df4344',
    guibg = bg_def
  },
  modified_selected = {
    guifg = '#df4344',
    guibg = bg_sel
  },
  indicator_selected = {
    guifg = bg_def,
    guibg = bg_def,
  },
  separator_selected = {
    guifg = bg_sel,
    guibg = bg_sel
  },
  separator_visible = {
    guifg = bg_def,
    guibg = bg_def
  },
  separator = {
    guifg = bg_def,
    guibg = bg_def
  },
  tab = {
    guifg = fg_def,
    guibg = bg_def
  },
  tab_selected = {
    guifg = fg_def,
    guibg = bg_sel
  },
  tab_close = {
    guifg = fg_def,
    guibg = bg_def
  },
  pick_selected = {
    guifg = '#89ddff',
    guibg = bg_sel,
    gui = "bold,italic"
  },
  pick_visible = {
    guifg = '#89ddff',
    guibg = bg_def,
    gui = "bold,italic"
  },
  pick = {
    guifg = '#89ddff',
    guibg = bg_def,
    gui = "bold,italic"
  }
}

require'bufferline'.setup{
  options = options,
  highlights = highlights
}
