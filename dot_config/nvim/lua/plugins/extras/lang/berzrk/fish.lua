return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "fish" },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "fish_lsp" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        fish_lsp = {},
      },
    },
  },
  {
    "maskudo/devdocs.nvim",
    optional = true,
    opts = {
      ensure_installed = {
        "fish~4.5",
      },
    },
  },
}
