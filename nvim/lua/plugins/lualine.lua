return {
  {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require('lualine').setup({
        options = {
          theme = "tokyonight", -- This matches your colorscheme
          globalstatus = true,   -- Keep one statusline at the bottom
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
      sections = {
        lualine_c = {
          {
            'filename',
            file_status = true,      -- Displays file status (readonly, modified)
            newfile_status = false,  -- Display new file status

            -- 0: Just filename
            -- 1: Relative path
            -- 2: Absolute path
            -- 3: Absolute path, with tilde as the home directory
            path = 1,

            -- This is the magic part:
            -- It will shorten the path if the window is narrower than this value.
            shorting_target = 40,

            symbols = {
              modified = ' ●',      -- Text to show when the file is modified.
              readonly = ' 🔒',      -- Text to show when the file is non-modifiable.
              unnamed = '[No Name]', -- Text to show for unnamed buffers.
              newfile = '[New]',     -- Text to show for newly created file before first write.
              }
            }
          }
        }
      })
    end
  }
}

