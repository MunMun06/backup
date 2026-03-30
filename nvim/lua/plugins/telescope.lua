return {
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                defaults = {
                    -- These belong in 'defaults', NOT in 'mappings'
                    layout_strategy = "horizontal",
                    layout_config = { prompt_position = "bottom", preview_width = 0.75},
                    sorting_strategy = "descending",
                    winblend = 0,
                  mappings = {
                    i = {}, -- insert mode
                    n = {}, -- normal mode
                  }
               }, -- Only actual keybindings go here
                pickers = {
                  find_files = {
                    previewer = false, -- disable preview for find files
                  }
                }
            })
            telescope.load_extension("fzf")
        end,
    },
}


