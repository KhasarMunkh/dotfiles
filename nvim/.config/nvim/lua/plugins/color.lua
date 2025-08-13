-- lua/plugins/color.lua
return {
    {
        "NvChad/nvim-colorizer.lua",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            filetypes = { "css", "scss", "html", "javascript", "typescript", "javascriptreact", "typescriptreact" },
            user_default_options = {
                names = false,        -- disable "red"/"blue" named colors (noisy)
                rgb_fn = true,        -- rgb(), rgba()
                hsl_fn = true,        -- hsl()
                tailwind = false,     -- we’ll handle Tailwind via the plugins below
                mode = "virtualtext", -- "background" can be heavy; VT is clean
            },
        },
        {
            "roobert/tailwindcss-colorizer-cmp.nvim",
            config = true,
            dependencies = {
                "hrsh7th/nvim-cmp"
            },
        },
        {
            "luckasRanarison/tailwind-tools.nvim",
            ft = { "html", "css", "scss", "javascript", "typescript", "javascriptreact", "typescriptreact" },
            dependencies = { "nvim-treesitter/nvim-treesitter" },
            opts = {
                document_color = {
                    enabled = true, -- highlight Tailwind colors inline
                    kind = "inline", -- "inline" (virt text) or "foreground"
                },
            },
        }
    }
}
