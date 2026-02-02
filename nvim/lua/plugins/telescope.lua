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
					mappings = {
						layout_strategy = "horizontal",
						layout_config = { prompt_position = "top" },
						sorting_strategy = "ascending",
						winblend = 0,
					},
				},
			})
			-- Load the fzf extension
			telescope.load_extension("fzf")
		end,
	},
}
