return {
  { import = "lazyvim.plugins.extras.lang.docker" },
  {
    "maskudo/devdocs.nvim",
    optional = true,
    opts = {
      ensure_installed = {
        "docker",
      },
    },
  },
}
