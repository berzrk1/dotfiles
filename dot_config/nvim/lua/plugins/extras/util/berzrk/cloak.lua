return {
  "laytan/cloak.nvim",
  event = "BufRead .env",
  cmd = { "CloakDisable", "CloakEnable", "ClockToggle" },
  opts = {},
  -- stylua: ignore
  keys = {
    { "<leader>ck", function() require("cloak").toggle() end, desc = "Toggle hide secrets" },
  },
}
