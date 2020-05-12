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
    node_movement = {
      enable = true,
      disable = {},
      keymaps = {
        parent_scope = "trk",
        child_scope = "trj",
        next_scope = "trl",
        previous_scope = "trh",
      }
    },
    ensure_installed = {} 
  }
end

return M
