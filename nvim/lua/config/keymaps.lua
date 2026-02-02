-- map(mode, shortcut, command, options)

local builtin = require("telescope.builtin")
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

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
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down and Center" })

-- Remap Ctrl+U (scroll up half page) to also center the cursor (zz)
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up and Center" })


-- Find files by name
map("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
-- Search for text inside files (Grep)
map("n", "<leader>sg", builtin.live_grep, { desc = "Search by Grep" })
-- Search through open buffers
map("n", "<leader>,", builtin.buffers, { desc = "Switch Buffer" })
-- Search help tags
map("n", "<leader>sh", builtin.help_tags, { desc = "Search Help" })

-- LSP Mappings
map("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover Info" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
map("n", "gr", require("telescope.builtin").lsp_references, { desc = "Go to References" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
