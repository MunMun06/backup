return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- 1. Map your linters to filetypes
    lint.linters_by_ft = {
      cpp = { "cpplint" },
      c = { "cpplint" },
      java = { "checkstyle" }

    }

    -- 2. Create the autocommand to trigger linting
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
