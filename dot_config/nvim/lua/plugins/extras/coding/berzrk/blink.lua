return {
  { import = "lazyvim.plugins.extras.coding.blink" },
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        ["<CR>"] = {}, -- disable Enter, use only <C-y>
      },
    },
  },
}
