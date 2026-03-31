return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        -- Keymaps (Inside config so they only load when Harpoon is ready)
        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon Add File" })
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = "Harpoon Menu"})
        
        vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end, {desc = "Slot 1"})
        vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end, {desc = "Slot 2"})
        vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end, {desc = "Slot 3"})
        vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end, {desc = "Slot 4"})

        -- Toggle previous & next buffers
        vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, {desc = "harpoon prev"}) 
        vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, {desc = "harpoon next"})
    end,
}
