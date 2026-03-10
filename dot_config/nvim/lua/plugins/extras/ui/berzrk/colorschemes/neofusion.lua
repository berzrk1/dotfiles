return {
  { "diegoulloao/neofusion.nvim", priority = 1000, config = true, opts = {} },
  {

    "LazyVim/LazyVim",
    opts = {
      colorscheme = "neofusion",

      -- colorscheme = function()
      --   require("tokyonight").load()
      -- end,
    },
  },
}
