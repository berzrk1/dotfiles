-- load lazy.nvim and yazi.nvim types for the annotations below
---@module "lazy"
---@module "yazi"

---@type LazySpec
return {
  {
    "mikavilpas/yazi.nvim",
    version = "*", -- use the latest stable version
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
      { "<leader>e", mode = { "n", "v" }, "<cmd>Yazi<cr>", desc = "Yazi (Current File)" },
      { "<leader>E", "<cmd>Yazi cwd<cr>", desc = "Yazi (CWD)" },
    },
    ---@type YaziConfig | {}
    opts = {
      open_for_directories = true, -- Use yazi instead of netrw/snacks when opening directory
      keymaps = {
        show_help = "<f1>",
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        enabled = false,
      },
    },
  },
}
