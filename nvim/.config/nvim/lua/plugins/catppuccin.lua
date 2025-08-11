return {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
        vim.cmd.colorscheme "catppuccin-macchiato"
        require("catppuccin").setup({
            flavour = "macchiato", -- latte, frappe, macchiato, mocha
            transparent_background = true,
            term_colors = true,
            styles = {
                comments = { "italic" },
                functions = { "italic" },
                keywords = { "italic" },
                strings = { "italic" },
                variables = {},
            },
            integrations = {
                cmp = true,
                telescope = true,
                treesitter = true,
                nvimtree = true,
                which_key = true,
            },
        })
    end
}
