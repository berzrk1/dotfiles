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
      -- { "<c-up>", "<cmd>Yazi toggle<cr>", desc = "Resume last Yazi Session" },
    },
    ---@type YaziConfig | {}
    opts = {
      open_for_directories = true, -- Use yazi instead of netrw/snacks when opening directory
      keymaps = {
        show_help = "<f1>",
      },
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    init = function()
      -- mark netrw as loaded so it's not loaded at all.
      --
      -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
      vim.g.loaded_netrwPlugin = 1
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        enabled = false,
      },
    },
  },
  -- {
  --   "folke/snacks.nvim",
  --   keys = {
  --     { "<leader>e", false },
  --     { "<leader>E", false },
  --   },
  -- },
}
