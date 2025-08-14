return {
    "lewis6991/hover.nvim",
    config = function()
        require("hover").setup({
            init = function()
                require("hover.providers.lsp")
            end,
            preview_opts = {
                border = "rounded",
                max_width = math.floor(vim.o.columns * 0.6),
                max_height = math.floor(vim.o.lines * 0.6),
            },
            title = true,
        })
        vim.keymap.set("n", "K", require("hover").hover, { desc = "Hover" })
        vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "Hover (select source)" })
    end,
}
