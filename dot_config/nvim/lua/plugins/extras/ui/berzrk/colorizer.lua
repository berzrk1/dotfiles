return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
  opts = {
    parsers = { css = true },
  },
  keys = {
    { "<leader>uC", "<cmd>ColorizerToggle<CR>", desc = "Disable Color Highlighter" },
  },
}
