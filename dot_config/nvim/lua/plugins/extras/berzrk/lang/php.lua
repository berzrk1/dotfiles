-- To change LSP
local lsp = "intelephense" -- Values: phpactor or intelephense
vim.g.lazyvim_php_lsp = lsp

return {
  { import = "lazyvim.plugins.extras.lang.php" },
}
