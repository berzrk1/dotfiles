return {
  { import = "lazyvim.plugins.extras.lang.clangd" },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["cpp"] = { "clang-format" },
      },
      formatters = {
        ["clang-format"] = {
          prepend_args = { "--style={BasedOnStyle: LLVM, IndentWidth: 4}" },
        },
      },
    },
  },
  {
    "maskudo/devdocs.nvim",
    optional = true,
    opts = {
      ensure_installed = {
        "cpp",
      },
    },
  },
}
