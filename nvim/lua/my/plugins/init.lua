return require("packer").startup(function(use)
  use("neovim/nvim-lspconfig")
  use("glepnir/lspsaga.nvim")
  use("nvim-treesitter/nvim-treesitter")

  use("navarasu/onedark.nvim")
  use({
    "hoob3rt/lualine.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons",
      opt = true,
    },
  })

  -- Navigation
  use("aserowy/tmux.nvim")
  use({
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
  })
  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
  })
  use({
    "nvim-telescope/telescope.nvim",
    requires = "nvim-lua/plenary.nvim",
  })

  -- Writing
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      -- "quangnguyen30192/cmp-nvim-ultisnips",
    },
  })
  use({
    "SirVer/ultisnips",
    requires = "honza/vim-snippets",
  })
  use("mhartington/formatter.nvim")
  use("b3nj5m1n/kommentary")
  use("windwp/nvim-autopairs")
end)
