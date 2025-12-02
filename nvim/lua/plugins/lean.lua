return {
  "Julian/lean.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  opts = {
    lsp = {
      on_attach = function(client, bufnr)
        -- Lean keybindings here if you want
      end,
    },
    mappings = true, -- enable default mappings
  },
}
