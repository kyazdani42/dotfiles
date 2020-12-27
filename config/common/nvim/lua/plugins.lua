vim.cmd [[packadd packer.nvim]]

require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}

  use {
    '~/dev/plugins/blue-moon',
    config = function() vim.cmd "colorscheme blue-moon" end
  }

  use '~/dev/plugins/nvim-web-devicons'
  use {
    '~/dev/plugins/nvim-tree.lua',
    config = function() require'tree-config'.setup() end
  }

  use {
    'rafcamlet/nvim-luapad',
    config = function() vim.g.luapad_preview = 0 end,
    ft = {'lua'}
  }

  use '~/dev/plugins/playground'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use {
    '~/dev/plugins/nvim-treesitter',
    config = function() require'ts'.setup() end
  }

  -- use 'TimUntersberger/neogit'

  use 'airblade/vim-gitgutter'
  use 'tpope/vim-fugitive'
  use 'APZelos/blamer.nvim'
  use 'tomtom/tcomment_vim'
  use 'tpope/vim-surround'
  use 'rust-lang/rust.vim'

  use 'junegunn/fzf'
  use {
    'junegunn/fzf.vim',
    config = require'fuzzy'.setup_fzf,
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
    'airblade/vim-rooter',
    config = function()
      vim.g.rooter_pattern = {
        '.git/',
        'package.json',
        'Cargo.toml'
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
    'neovim/nvim-lspconfig',
    requires = {'nvim-lua/completion-nvim'},
    config = function() require'lsp'.setup() end
  }

  use {
    'neoclide/coc.nvim',
    branch = 'release',
    config = function() require'coc'.setup() end,
    ft = {
      'typescript',
      'typescriptreact',
      'javascript',
      'javascriptreact',
      'html',
      'json',
      'css',
      'rust'
    },
  }
end)