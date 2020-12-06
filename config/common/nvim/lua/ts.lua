local api = vim.api
local M = {}

local synoff = function()
  local filetypes = vim.fn.join({ "lua", "javascript", "javascripreact", "typescript", "typescriptreact", "c", "cpp", "query", "rust", "go", "json", "html", "css", "scheme", "sh", "fennel", "php", "python", "ruby", "toml" }, ",")
  vim.cmd("au FileType "..filetypes.." set syn=off")
  vim.cmd("au FileType "..filetypes.." lua require'matchit'.setup()")
end

function M.setup()
  synoff()
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
      indent = {
        enable = true,
      },
      ensure_installed = 'all',
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["<leader>V"] = "@function.outer", -- replace with block.inner and block.outer when its supported in more languages
            ["<leader>v"] = "@function.inner"
          }
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>f"] = "@parameter.inner", -- replace with block.inner when its supported in more languages
          },
          swap_previous = {
            ["<leader>a"] = "@parameter.inner",
          },
        },
      },
    }

  api.nvim_set_keymap('n', 'R', ':write | edit | TSBufEnable highlight<CR>', {});
  api.nvim_exec([[
    command! ToggleTsVtx lua require'ts'.toggle_ts_virt_text()
    hi TsVirtText guifg=#89ddff
    augroup TSVirtualText
      au!
      au BufEnter,CursorMoved,CursorMovedI,WinEnter,CompleteDone,InsertEnter,InsertLeave * lua require'ts'.ts_virt_text()
    augroup END

    command! ToggleTsHlGroups lua require'ts'.toggle_ts_hl_groups()
    augroup TSVirtualTextHlGroups
      au!
      au BufEnter,CursorMoved,CursorMovedI,WinEnter,CompleteDone,InsertEnter,InsertLeave * lua require'ts'.ts_hl_groups()
    augroup END
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

local hl_virt_enable = false
local hl_ns_id = api.nvim_create_namespace('TSVirtualTextHlGroups')

function M.toggle_ts_hl_groups()
  if hl_virt_enable then
    hl_virt_enable = false
    api.nvim_buf_clear_namespace(0, hl_ns_id, 0,-1)
  else
    hl_virt_enable = true
    M.ts_hl_groups()
  end
end

function M.ts_hl_groups()
  if not hl_virt_enable then return end

  local ns = api.nvim_get_namespaces()['treesitter/highlighter']
  local _, lnum, lcol = unpack(vim.fn.getcurpos())
  local extmarks = api.nvim_buf_get_extmarks(0, ns, {lnum-1, lcol-1}, {lnum-1, -1}, { details = true })
  local groups = {}

  for i, ext in ipairs(extmarks) do
    local infos = ext[4]
    if infos then
      local str = infos.hl_group
      if i ~= #extmarks then
        str = str..' > '
      end
      table.insert(groups, {str, infos.hl_group})
    end
  end

  api.nvim_buf_clear_namespace(0, hl_ns_id, 0,-1)
  api.nvim_buf_set_virtual_text(0, hl_ns_id, lnum-1, groups, {})
end

return M
