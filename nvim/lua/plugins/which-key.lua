return {
  "folke/which-key.nvim",
  event = "VeryLazy", -- Loads the plugin only when you start typing keys
  opts = {
    -- You can leave this empty to use the default settings
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
