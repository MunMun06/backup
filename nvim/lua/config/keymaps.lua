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
end, opts, {desc = "C++"})

map("n", "<leader>k", function()
  local dir = vim.fn.expand("%:p:h")
  local file = vim.fn.expand("%:t")
  local out = vim.fn.expand("%:t:r")

  vim.cmd("!zsh ~/scripts/compile_c.sh '" .. dir .. "' '" .. file .. "' '" .. out .. "'")
end, opts,{desc = "C"})

map("n", "<leader>h", function()
  local dir = vim.fn.expand("%:p:h")
  local file = vim.fn.expand("%:t")
  -- local out = vim.fn.expand("%:t:r")

  vim.cmd("!zsh ~/scripts/compile_java.sh '" .. dir .. "' '" .. file .. "'")
end, opts, {desc = "java"})

-- Remap Ctrl+D (scroll down half page) to also center the cursor (zz)
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down and Center" })

-- Remap Ctrl+U (scroll up half page) to also center the cursor (zz)
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up and Center" })


-- Find files by name
map("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
-- Search for text inside files (Grep)
map("n", "<leader>fg", builtin.live_grep, { desc = "Search by Grep" })
-- Search through open buffers
map("n", "<leader>fb", builtin.buffers, { desc = "Switch Buffer" })
-- Search help tags
map("n", "<leader>fh", builtin.help_tags, { desc = "search help tags" })

-- Find all files by name
map("n", "<leader>fk", function() builtin.find_files({hidden = true, no_ignore = true}) end, { desc = "Find all Files" })
-- Search for text inside all files (Grep)
map("n", "<leader>fj", function() builtin.live_grep({hidden = true, no_ignore = true}) end, { desc = "Search all by Grep" })

-- these 2 dont need hidden version
-- Search through open all buffers
-- map("n", "<leader>fk", builtin.buffers({hidden = true, no_ignore = true}), { desc = "Switch all Buffer" })
-- Search all help tags
-- map("n", "<leader>fl", builtin.help_tags({hidden = true, no_ignore = true}), { desc = "search all help tags" })

-- LSP Mappings
map("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover Info" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
map("n", "gr", require("telescope.builtin").lsp_references, { desc = "Go to References" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

-- Always start search in very magic mode
map('n', '/', '/\\v', opts)
map('n', '?', '?\\v', opts)

-- Make :s start with \v automatically
vim.cmd([[
cnoreabbrev <expr> s/  getcmdtype() == ':' && getcmdline() ==# 's/'  ? 's/\v'  : 's/'
cnoreabbrev <expr> %s/ getcmdtype() == ':' && getcmdline() ==# '%s/' ? '%s/\v' : '%s/'
]])
-- cnoreabbrev is command-line mode non-recursive abbreviation (only affect : in normal mode)
-- <expr> intrepret the replaced text as vimscript expression not normal text
-- conditions. ensure that we are in command-line mode, case-sensitive check the entire command-line content
--  is 's/'
-- ternary 

-- Better tab navigation
-- bruh <M-h> is alt + h
map("n", "H", ":tabprevious<CR>", opts) -- Go to previous tab
map("n", "L", ":tabnext<CR>", opts)     -- Go to next tab
