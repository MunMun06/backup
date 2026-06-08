return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  -- { -- optional cmp completion source for require statements and module annotations
  --   "hrsh7th/nvim-cmp",
  --   opts = function(_, opts)
  --     opts.sources = opts.sources or {}
  --     table.insert(opts.sources, {
  --       name = "lazydev",
  --       group_index = 0, -- set group index to 0 to skip loading LuaLS completions
  --     })
  --   end,
  -- },
  { -- optional blink completion source for require statements and module annotations
    "saghen/blink.cmp",
    dependencies = { 'rafamadriz/friendly-snippets'},
    version = '1.*',
    build = 'cargo build --release',
    ---@module 'blink.cmp'
    ---@typeblink.cmp.Config 
    opts = {
      -- KEYMAPS go here (Root level)
      keymap = {
        preset = "default",
        -- we will be using default instead
        --["<CR>"] = { "accept", "fallback" }, -- <C-y>
        --["<Tab>"] = { "select_next", "fallback" }, -- <C-n> 
        --["<S-Tab>"] = { "select_prev", "fallback" }, -- <C-p>
      },

      -- COMPLETION settings go here (Root level)
      completion = {
        documentation = { auto_show = false },
      },

      -- SOURCES go here
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
    },
  },  -- { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim
}
