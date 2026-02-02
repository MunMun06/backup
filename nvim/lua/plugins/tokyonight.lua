return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    -- This function is called when the theme is loaded
    on_highlights = function(hl, c)
      -- 'hl' is the highlight table, 'c' is the color palette
      hl.LineNr = {
        fg = "#FFA500", -- this is suppose to be relative line 
        bold = true,    -- but i change cursor line by changing this
      }
      hl.CursorLineNr = {
--        fg = "#FFFFFF", -- this is suppose to be cursor line
--        bold = true,-- but this doesnt seem to do anything 
      }
    end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd[[colorscheme tokyonight]]

  end,
}
