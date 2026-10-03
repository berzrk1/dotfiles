return {
  { import = "lazyvim.plugins.extras.util.chezmoi" },
  -- <leader>fc: chezmoi-managed files, same picker as <leader>sz and the dashboard's Config
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>fc", "<leader>sz", remap = true, desc = "Config" },
    },
  },
  -- Dashboard: Find Config greps the chezmoi source instead of the nvim config.
  -- berzrk.snacks adds the entry; extras load alphabetically, so it exists by now.
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      for _, item in ipairs(opts.dashboard.preset.keys) do
        if item.key == "C" then
          item.action = function()
            LazyVim.pick("live_grep", { cwd = vim.fn.expand("~/.local/share/chezmoi") })()
          end
        end
      end
    end,
  },
}
