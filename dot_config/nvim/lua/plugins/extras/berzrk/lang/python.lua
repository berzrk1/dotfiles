-- To change LSP
local lsp = "ty" -- Values: ty, pyright or basedpyright
vim.g.lazyvim_python_lsp = lsp

return {
  { import = "lazyvim.plugins.extras.lang.python" },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      for _, server in ipairs({ "pyright", "basedpyright", "ty" }) do
        opts.servers[server] = opts.servers[server] or {}
        opts.servers[server].enabled = server == lsp
      end
    end,
  },
  -- Debug adapter for nvim-dap-python (LazyVim's Python extra doesn't install it)
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "debugpy" } },
  },
  -- Dashboard New Project (berzrk.snacks): Python runs `uv init` in the chosen folder
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        new_project = {
          Python = function()
            if vim.fn.executable("uv") ~= 1 then
              vim.notify("uv is not installed", vim.log.levels.ERROR, { title = "New Project" })
              return
            end
            local function uv_init(args)
              vim.system(
                vim.list_extend({ "uv", "init" }, args),
                { cwd = vim.fn.getcwd(), text = true },
                vim.schedule_wrap(function(result)
                  local output = vim.trim((result.stderr or "") .. (result.stdout or ""))
                  local level = result.code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR
                  vim.notify(output, level, { title = "uv init" })
                end)
              )
            end
            vim.ui.select({ "app", "bare", "lib", "script" }, {
              prompt = "uv init",
              format_item = function(kind)
                return kind == "app" and "app (default)" or kind
              end,
            }, function(kind)
              if not kind then
                return
              end
              if kind ~= "script" then
                return uv_init({ "--" .. kind })
              end
              vim.ui.input({ prompt = "Script name", default = "main.py" }, function(name)
                if name and vim.trim(name) ~= "" then
                  uv_init({ "--script", vim.trim(name) })
                end
              end)
            end)
          end,
        },
      },
    },
  },
  -- Projects picker: a folder with pyproject.toml counts as a project, even without .git
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      local defaults = require("snacks.picker.config.sources").projects.patterns
      local projects = vim.tbl_get(opts, "picker", "sources", "projects") or {}
      projects.patterns = vim.list_extend(vim.deepcopy(projects.patterns or defaults), { "pyproject.toml" })
      opts.picker = opts.picker or {}
      opts.picker.sources = opts.picker.sources or {}
      opts.picker.sources.projects = projects
    end,
  },
}
