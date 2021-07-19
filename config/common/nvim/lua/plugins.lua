vim.cmd "packadd! packer.nvim"

require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}

  use {
    '~/dev/plugins/blue-moon',
    config = function() vim.cmd "colorscheme blue-moon" end
  }

  use {
    '~/dev/plugins/nvim-web-devicons',
    config = function()
      require "nvim-web-devicons".setup {
        override = {
          html = {
            icon = "",
            color = "#DE8C92",
            name = "html"
          },
          css = {
            icon = "",
            color = "#61afef",
            name = "css"
          },
          js = {
            icon = "",
            color = "#EBCB8B",
            name = "js"
          },
          png = {
            icon = " ",
            color = "#BD77DC",
            name = "png"
          },
          jpg = {
            icon = " ",
            color = "#BD77DC",
            name = "jpg"
          },
          jpeg = {
            icon = " ",
            color = "#BD77DC",
            name = "jpeg"
          },
          mp3 = {
            icon = "",
            color = "#C8CCD4",
            name = "mp3"
          },
          mp4 = {
            icon = "",
            color = "#C8CCD4",
            name = "mp4"
          },
          lock = {
            icon = "",
            color = "#117cad",
            name = "lock"
          },
          graphql = {
            icon = "",
            color = "#e632ad",
            name = "graphql"
          },
          gql = {
            icon = "",
            color = "#e632ad",
            name = "graphql"
          },
        }
      }
    end
  }

  use {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {}
    end
  }

  use {
    '~/dev/plugins/nvim-tree.lua',
    config = function() require'plugins.nvim-tree' end
  }
  use {
    'akinsho/nvim-bufferline.lua',
    config = function() require'plugins.bufferline' end
  }

  use {
    'rafcamlet/nvim-luapad',
    config = function() vim.g.luapad_preview = 0 end,
    ft = {'lua'}
  }

  use '~/dev/plugins/playground'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use {
    '~/dev/plugins/nvim-treesitter',
    config = function() require'plugins.treesitter'.setup() end
  }
  use {
    'windwp/nvim-ts-autotag',
    config = function() require'nvim-ts-autotag'.setup() end
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function() require'plugins.gitsigns' end
  }

  use 'tpope/vim-fugitive'
  use 'APZelos/blamer.nvim'
  use {
    'b3nj5m1n/kommentary',
    setup = function()
      vim.g.kommentary_create_default_mappings = false
    end,
    config = function()
      require('kommentary.config').configure_language("default", {
        prefer_single_line_comments = true,
      })
      vim.api.nvim_set_keymap("n", "++", "<Plug>kommentary_line_default", { silent = true })
      vim.api.nvim_set_keymap("v", "++", "<Plug>kommentary_visual_default", { silent = true })
    end
  }
  use 'tpope/vim-surround'
  use 'rust-lang/rust.vim'

  use 'junegunn/fzf'
  use {
    'junegunn/fzf.vim',
    config = function() require'plugins.fzf' end,
  }
  use {
    'editorconfig/editorconfig',
    setup = function()
      vim.g.EditorConfig_exclude_patterns = {
        'fugitive://.*',
        'scp://.*'
      }
    end
  }

  use {
    'plasticboy/vim-markdown',
    setup = function() vim.g.vim_markdown_folding_disabled = 1 end
  }

  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require'colorizer'.setup() end
  }

  use {
    'steelsojka/pears.nvim',
    config = function() require'pears'.setup() end
  }

  --[[ use {
    'hrsh7th/vim-vsnip'
  } ]]

  use {
    'hrsh7th/nvim-compe',
    config = function() require 'plugins.compe' end
  }
  use {
    'neovim/nvim-lspconfig',
    config = function() require'lsp.lsp'.setup() end,
  }
  use {
    'glepnir/lspsaga.nvim',
    config = function() require'lsp.saga'.setup() end
  }

  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}, config = function() require'plugins.dap' end }

  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }

  use {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
        dimming = {
          alpha = 0.3,
          color = { "#a6accd" },
        }
      }
    end
  }
end)
