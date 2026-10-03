-- C/C++: LazyVim's clangd and CMake setups; C/C++-specific settings go below the imports
return {
  { import = "lazyvim.plugins.extras.lang.clangd" },
  { import = "lazyvim.plugins.extras.lang.cmake" },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
      },
      formatters = {
        ["clang-format"] = {
          prepend_args = { "--style={BasedOnStyle: LLVM, IndentWidth: 4}" },
        },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "clang-format" } },
  },
  -- guess-indent (berzrk.ui.guess-indent, if enabled): keep the configured indent in C/C++
  {
    "nmac427/guess-indent.nvim",
    optional = true,
    opts = { filetype_exclude = { "c", "cpp" } },
  },
  -- CMake keys in the <leader>c group of C/C++/CMake buffers
  -- (run from the project root: cmake-tools uses the cwd)
  {
    "Civitasv/cmake-tools.nvim",
    cmd = { "CMakeQuickStart" }, -- lets lazy.nvim load it for the dashboard's New Project
    keys = {
      { "<leader>cx", "<cmd>CMakeRun<cr>", desc = "CMake Run", ft = { "c", "cpp", "cmake" } },
      { "<leader>cX", ":CMakeLaunchArgs ", desc = "CMake Set Run Args", ft = { "c", "cpp", "cmake" } },
      { "<leader>cb", "<cmd>CMakeBuild<cr>", desc = "CMake Build", ft = { "c", "cpp", "cmake" } },
      { "<leader>cB", "<cmd>CMakeSelectBuildType<cr>", desc = "CMake Build Type", ft = { "c", "cpp", "cmake" } },
      { "<leader>cD", "<cmd>CMakeDebug<cr>", desc = "CMake Debug", ft = { "c", "cpp", "cmake" } },
      { "<leader>cg", "<cmd>CMakeGenerate<cr>", desc = "CMake Generate", ft = { "c", "cpp", "cmake" } },
      { "<leader>ct", "<cmd>CMakeSelectLaunchTarget<cr>", desc = "CMake Launch Target", ft = { "c", "cpp", "cmake" } },
    },
  },
  -- Dashboard New Project (berzrk.snacks): C/C++ creates a CMake project with CMakeQuickStart
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        new_project = {
          ["C/C++"] = function()
            vim.cmd("CMakeQuickStart")
          end,
        },
      },
    },
  },
  -- Projects picker: a folder with CMakeLists.txt counts as a project, even without .git
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      local defaults = require("snacks.picker.config.sources").projects.patterns
      local projects = vim.tbl_get(opts, "picker", "sources", "projects") or {}
      projects.patterns = vim.list_extend(vim.deepcopy(projects.patterns or defaults), { "CMakeLists.txt" })
      opts.picker = opts.picker or {}
      opts.picker.sources = opts.picker.sources or {}
      opts.picker.sources.projects = projects
    end,
  },
}
