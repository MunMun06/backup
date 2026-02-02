---@diagnostic disable: undefined-doc-name
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true }, -- prevent bigfile like LSP from going into buffer (would that ever happened?)
		dashboard = { enabled = true }, -- dashboard
		explorer = { enabled = true }, -- my leader e that will sadly meet its end
		indent = { enabled = true }, -- maybe for indent commenting on new line
		input = { enabled = true }, -- maybe for enter and its choose the completion
		picker = { enabled = true }, -- we got telescope
		notifier = { enabled = false }, -- floating notification
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = false }, -- smooth scrolling
		statuscolumn = { enabled = true },
		words = { enabled = true },
	},
}

