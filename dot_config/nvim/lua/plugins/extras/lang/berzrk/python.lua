vim.g.lazyvim_python_lsp = "ty"
vim.g.lazyvim_python_ruff = "ruff"

return {
  { import = "lazyvim.plugins.extras.lang.python" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "requirements",
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "ty",
      },
    },
  },
  {
    "maskudo/devdocs.nvim",
    opts = {
      ensure_installed = {
        "python~3.14",
      },
    },
  },
}
