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
        scope_incremental = "<leader>n",
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
      au BufEnter,CursorMoved,CursorMovedI,WinEnter,CompleteDone,InsertEnter,InsertLeave * lua require'ts'.set_virt()
    augroup END

    function
  ]], '')
end

local virt_enable = false

local ns_id = api.nvim_create_namespace('TSVirtualText')

function M.toggle_ts_virt()
  if virt_enable then
    virt_enable = false
    api.nvim_buf_clear_namespace(0, ns_id, 0,-1)
  else
    virt_enable = true
    M.set_virt()
  end
end

function M.set_virt()
  if not virt_enable then return end

  local node_info = require'nvim-treesitter'.statusline()
  if not node_info or node_info == "" then return end

  local cursor = api.nvim_win_get_cursor(0)
  api.nvim_buf_clear_namespace(0, ns_id, 0,-1)
  api.nvim_buf_set_virtual_text(0, ns_id, cursor[1]-1, {{ node_info, "TsVirtText" }}, {})
end

function M.list_hl()
  local ns = api.nvim_get_namespaces().treesitter_hl
  local node = ts_utils.get_node_at_cursor(0, true)
  local srow, scol, erow, ecol = node:range()
  local extmarks = api.nvim_buf_get_extmarks(0, ns, {srow, scol}, {erow, ecol}, {})
  for _, ext in ipairs(extmarks) do
    -- extmark ID. There is no way to retrieve any hl data from it yet.
    -- maybe put some work upstream if i have some time
    print(vim.inspect(ext[1]))
  end
end

return M
