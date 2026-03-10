return {
  { import = "plugins.extras.lang.python" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "htmldjango",
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "django-template-lsp",
      },
    },
  },
  {
    "maskudo/devdocs.nvim",
    opts = {
      ensure_installed = {
        "django~6.0",
      },
    },
  },
}
