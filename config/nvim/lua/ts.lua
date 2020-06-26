local api = vim.api
local M = {}

function M.setup()
  require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = false,
      disable = {},
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

function M.toggle_ts_virt()
  if virt_enable then
    virt_enable = false
    api.nvim_buf_clear_namespace(0, 0, 0,-1)
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
  api.nvim_buf_clear_namespace(0, 0, 0,-1)
  api.nvim_buf_set_virtual_text(0, 0, cursor[1]-1, {{ node_info, "TsVirtText" }}, {})
end

return M
