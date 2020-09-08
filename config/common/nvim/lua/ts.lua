local api = vim.api
local M = {}
local ts_utils = require 'nvim-treesitter.ts_utils'

function M.setup()
  require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      disable = {},
      keymaps = {
        init_selection = "<leader>n",
        node_incremental = "n",
        scope_incremental = "<leader>m",
        node_decremental = "m"
      }
    },
    ensure_installed = {}
  }

  api.nvim_set_keymap('n', 'R', ':write | edit | TSBufEnable highlight<CR>', {});
  api.nvim_exec([[
    command! ToggleTsVtx lua require'ts'.toggle_ts_virt()
    hi TsVirtText guifg=#89ddff
    augroup TSVirtualText
      au!
      au BufEnter,CursorMoved,CursorMovedI,WinEnter,CompleteDone,InsertEnter,InsertLeave * lua require'ts'.ts_virt_text()
    augroup END

    nnoremap <C-c> :lua require'ts'._hl_under_cursor()<CR>

  ]], '')
end

local virt_enable = false

local ns_id = api.nvim_create_namespace('TSVirtualText')

function M.toggle_ts_virt_text()
  if virt_enable then
    virt_enable = false
    api.nvim_buf_clear_namespace(0, ns_id, 0,-1)
  else
    virt_enable = true
    M.ts_virt_text()
  end
end

function M.ts_virt_text()
  if not virt_enable then return end

  local node_info = require'nvim-treesitter'.statusline()
  if not node_info or node_info == "" then return end

  local cursor = api.nvim_win_get_cursor(0)
  api.nvim_buf_clear_namespace(0, ns_id, 0,-1)
  api.nvim_buf_set_virtual_text(0, ns_id, cursor[1]-1, {{ node_info, "TsVirtText" }}, {})
end

function M._hl_under_cursor()
  local ns = api.nvim_get_namespaces().treesitter_hl
  local _, lnum, col = unpack(vim.fn.getcurpos())
  local extmarks = api.nvim_buf_get_extmarks(0, ns, {lnum-1, col-1}, {lnum-1, -1}, { details = true })
  local ext = extmarks[1]
  local infos = ext[4]
  -- TODO: find a way to get the extmark under cursor, for now leave it as is
  if not infos then return print("[no hl group found]") end

  local start = " ["..(ext[2]+1).."|"..ext[3].."]"
  local end_ = "["..(infos.end_row+1).."|".. infos.end_col.."]"
  local str = infos.hl_group..start.." -> "..end_
  print(str)
end

return M
