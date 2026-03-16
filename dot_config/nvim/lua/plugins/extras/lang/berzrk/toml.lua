return {
  { import = "lazyvim.plugins.extras.lang.toml" },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["toml"] = { "taplo" },
      },
    },
  },
}
