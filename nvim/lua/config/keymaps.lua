-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- % is current filename
-- %< is current filename without extension
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>j", function()
  local dir = vim.fn.expand("%:p:h")
  local file = vim.fn.expand("%:t")
  local out = vim.fn.expand("%:t:r")

  vim.cmd("!zsh ~/scripts/compile_cpp.sh '" .. dir .. "' '" .. file .. "' '" .. out .. "'")
end, opts)

map("n", "<leader>k", function()
  local dir = vim.fn.expand("%:p:h")
  local file = vim.fn.expand("%:t")
  local out = vim.fn.expand("%:t:r")

  vim.cmd("!zsh ~/scripts/compile_c.sh '" .. dir .. "' '" .. file .. "' '" .. out .. "'")
end, opts)

map("n", "<leader>h", function()
  local dir = vim.fn.expand("%:p:h")
  local file = vim.fn.expand("%:t")
  -- local out = vim.fn.expand("%:t:r")

  vim.cmd("!zsh ~/scripts/compile_java.sh '" .. dir .. "' '" .. file .. "'")
end, opts)

-- Remap Ctrl+D (scroll down half page) to also center the cursor (zz)
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down and Center" })

-- Remap Ctrl+U (scroll up half page) to also center the cursor (zz)
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up and Center" })
