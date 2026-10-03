-- My changes to the default snacks
return {
  { import = "lazyvim.plugins.extras.editor.snacks_picker" },
  -- Project picker roots; scratch picker keeps <c-n> for moving down (new scratch on <a-n>)
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          projects = {
            dev = { "~/Dev", "~/Git", "~/Projects" },
          },
          scratch = {
            title = "Scratch · <a-n> new · <c-x> delete",
            win = {
              input = {
                keys = {
                  ["<c-n>"] = { "list_down", mode = { "i", "n" } },
                  ["<a-n>"] = { "scratch_new", mode = { "i", "n" } },
                },
              },
            },
          },
        },
      },
    },
  },
  -- Picker: drop <leader>: (command history stays on <leader>sc)
  -- and <leader>n (notification history stays on <leader>snh)
  -- Scratch: <leader>< toggles, <leader>> selects (instead of <leader>. and <leader>S)
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>:", false },
      { "<leader>n", false },
      { "<leader>.", false },
      { "<leader>S", false },
      { "<leader><lt>", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>>", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    },
  },
  -- Dashboard: Remove the lazy and lazy extras entry from the dashboard
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.dashboard.preset.keys = vim.tbl_filter(function(item)
        return item.action ~= ":Lazy" and item.action ~= ":LazyExtras"
      end, opts.dashboard.preset.keys)
    end,
  },
  -- Dashboard: Find Text on t instead of g
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      for _, item in ipairs(opts.dashboard.preset.keys) do
        if item.desc == "Find Text" then
          item.key = "t"
        end
      end
    end,
  },
  -- Dashboard: grep the nvim config contents, next to the Config entry
  -- (berzrk.util.chezmoi points it at the chezmoi source instead)
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      local keys = opts.dashboard.preset.keys
      local index = #keys
      for i, item in ipairs(keys) do
        if item.key == "c" then
          index = i
          break
        end
      end
      table.insert(keys, index + 1, {
        icon = " ",
        key = "C",
        desc = "Find Config",
        action = function()
          LazyVim.pick("live_grep", { cwd = vim.fn.stdpath("config") })()
        end,
      })
    end,
  },
  -- Dashboard: New Project, next to Projects. Lang extras register project types in
  -- dashboard.new_project = { [name] = function() end }; the entry hides when there are none.
  -- Flow: pick a type, pick a folder (created and :cd'd into), then run the type's setup.
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      local keys = opts.dashboard.preset.keys
      local index = #keys
      for i, item in ipairs(keys) do
        if item.key == "p" then
          index = i
          break
        end
      end
      table.insert(keys, index + 1, {
        icon = " ",
        key = "P",
        desc = "New Project",
        enabled = function(dashboard)
          return next(dashboard.new_project or {}) ~= nil
        end,
        action = function()
          local types = Snacks.config.dashboard.new_project or {}
          local names = vim.tbl_keys(types)
          table.sort(names)
          vim.ui.select(names, { prompt = "Project type" }, function(name)
            if not name then
              return
            end
            vim.ui.input({ prompt = "Project folder", default = "~/Projects/", completion = "dir" }, function(input)
              if not input or vim.trim(input) == "" then
                return
              end
              local dir = vim.fs.normalize(vim.fn.expand(vim.trim(input)))
              vim.fn.mkdir(dir, "p")
              vim.cmd.cd(vim.fn.fnameescape(dir))
              types[name]()
            end)
          end)
        end,
      })
    end,
  },
}
