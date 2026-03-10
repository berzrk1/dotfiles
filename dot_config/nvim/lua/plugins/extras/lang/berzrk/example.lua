-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
if true then return {} end

return {
  -- If there is already a basic configuration from LazyVim
  { import = "lazyvim.plugins.extras.lang.clangd" },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {},
    },
  },

  -- Mason
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {},
    },
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lspname = {},
        lspname2 = {},
      },
    },
  },

  -- Conform
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["c"] = { "clang-format" },
      },
    },
  },

  -- Linter
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft.dockerfile = { "" }
      opts.linters_by_ft.sh = { "" }
    end,
  },
  -- Devdocs
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
