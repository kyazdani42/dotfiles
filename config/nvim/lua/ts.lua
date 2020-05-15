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
end

return M
