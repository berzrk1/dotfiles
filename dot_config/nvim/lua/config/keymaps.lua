-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Buffers
map("n", "<leader>bq", function()
  Snacks.bufdelete()
end, { desc = "Quit Buffer" })
map("n", "<leader>ba", function()
  Snacks.bufdelete.all()
end, { desc = "Delete All Buffers" })
-- switch to other buffer on <leader>a instead of <leader>`
vim.keymap.del("n", "<leader>`")
map("n", "<leader>a", "<cmd>e #<cr>", { desc = "Switch to Last Buffer" })

-- Dashboard
map("n", "<leader>h", function()
  if LazyVim.has("snacks.nvim") then
    Snacks.dashboard()
  elseif LazyVim.has("alpha-nvim") then
    require("alpha").start(true)
  elseif LazyVim.has("dashboard-nvim") then
    vim.cmd("Dashboard")
  end
end, { desc = "Dashboard" })

-- Lazy: replace LazyVim's <leader>l / <leader>L with a <leader>l group
vim.keymap.del("n", "<leader>l")
vim.keymap.del("n", "<leader>L")
require("which-key").add({ { "<leader>l", group = "Lazy" } })
map("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy" })
map("n", "<leader>lx", "<cmd>LazyExtras<cr>", { desc = "Lazy Extras" })
map("n", "<leader>lL", function()
  LazyVim.news.changelog()
end, { desc = "LazyVim Changelog" })

-- Windows: split right on <leader>\ instead of <leader>|
vim.keymap.del("n", "<leader>|")
map("n", "<leader>\\", "<C-W>v", { desc = "Split Window Right", remap = true })
