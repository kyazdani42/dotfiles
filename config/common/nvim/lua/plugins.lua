vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}

  use {
    '~/dev/plugins/blue-moon',
    config = function() vim.cmd "colorscheme blue-moon" end
  }

  use {
    '~/dev/plugins/nvim-tree.lua',
    setup = function() require'tree-config'.setup() end
  }

  use {
    '~/dev/plugins/playground',
    requires = {
      '~/dev/plugins/nvim-treesitter',
      config = function() require'ts'.setup() end
    }
  }

  use 'airblade/vim-gitgutter'
  use 'tpope/vim-fugitive'
  use 'APZelos/blamer.nvim'
  use 'tomtom/tcomment_vim'
  use 'tpope/vim-surround'
  use 'sheerun/vim-polyglot'
  use 'rust-lang/rust.vim'

  use {
    'junegunn/fzf.vim',
    setup = require'fuzzy'.setup_fzf
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
    setup = function()
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
    'nvim-lua/completion-nvim',
    requires = {
      'neovim/nvim-lspconfig',
      config = function() require'lsp'.setup() end
    }
  }

  use {
    'neoclide/coc.nvim', 
    branch = 'release', 
    config = function() require'coc'.setup() end,
    ft = {
      'typescript',
      'javascript',
      'html',
      'json',
      'css',
      'rust'
    },
  }
end)
