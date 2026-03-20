return {
  { import = "lazyvim.plugins.extras.editor.snacks_picker" },
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          projects = {
            dev = { "~/Dev", "~/Git", "~/Projects" },
          },
        },
      },
    },
  },
}
