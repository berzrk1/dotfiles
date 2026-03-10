return {
  { import = "lazyvim.plugins.extras.lang.clangd" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {},
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {},
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["c"] = { "clang-format" },
      },
    },
  },
  {
    "maskudo/devdocs.nvim",
    optional = true,
    opts = {
      ensure_installed = {
        "c",
      },
    },
  },
}
