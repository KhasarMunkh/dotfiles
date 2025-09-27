return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            ensure_installed = {
                "lua",
                "python",
                "javascript",
                "typescript",
                "tsx",
                "c_sharp",
                "go",
                "markdown",
                "markdown_inline",
                "html",
                "css",
                "json",
                "bash",
                "svelte",
            },
            highlight = { enable = true },
            indent = { enable = true },
            rainbow = {
                enable = true,
                extended_mode = true,
                max_file_lines = nil,
            },
        })
    end,
}
