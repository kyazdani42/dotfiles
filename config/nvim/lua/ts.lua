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

  api.nvim_command("hi def TSNodeHighlight guibg=#89ddff guifg=#1b1e2b")
  api.nvim_set_keymap("n", "tnn", ":lua require'ts'.highlight_node()<CR>", { silent = true})
end

local namespaces = {}

function M.highlight_node()
  local bufnr = api.nvim_get_current_buf()

  vim.defer_fn(
    function()
      local buf_state = require'nvim-treesitter'.get_buf_state(bufnr)
      if not buf_state then return end
      if not namespaces[bufnr] then
        namespaces[bufnr] = api.nvim_create_namespace('TsHighlight'..tostring(bufnr))
      end
      api.nvim_buf_clear_namespace(bufnr, namespaces[bufnr], 0, -1)

      local node = buf_state.current_node
      local srow, scol, erow, ecol = node:range()
      local t = vim.region(bufnr, {srow, scol}, {erow, ecol}, '', false)
      for line, v in pairs(t) do
        api.nvim_buf_add_highlight(bufnr, namespaces[bufnr], 'TSNodeHighlight', line, v[1], v[2])
      end
    end, 10)

  vim.defer_fn(
    function()
      if not namespaces[bufnr] then return end
      api.nvim_buf_clear_namespace(bufnr, namespaces[bufnr], 0, -1)
    end, 500)

end

return M
