return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts

  -- VERY IMPORTANT. g? in oil open help menu
  opts = {
    default_file_explorer = true,
    delete_to_trash = false,
    skip_confirm_for_simple_edits = false,
  },
  -- Optional dependencies
  dependencies = { { "nvim-tree/nvim-web-devicons", opts = {} } },
  -- lazy loading is not recommended because it is very tricky to make it work correctly in all situation
  config = true,
  lazy = false,
}


