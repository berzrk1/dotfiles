return {
  { import = "lazyvim.plugins.extras.lang.markdown" },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      render_modes = true,
      checkebox = {
        enabled = true,
      },
      heading = {
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        position = "inline",
        width = "block",
        left_margin = 0.5,
        left_pad = 0.2,
        right_pad = 0.2,
      },
    },
  },
}
