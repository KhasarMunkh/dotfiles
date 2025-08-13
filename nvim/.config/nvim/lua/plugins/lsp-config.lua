return {
    {
        "mason-org/mason.nvim",
        opts = {},
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "lua_ls",
                "ts_ls",
                "gopls",
                "tailwindcss",
                "emmet_language_server",
                "eslint",
                "html",
            }
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.cssls.setup({
                capabilities = capabilities,
                settings = {
                    css = {
                        validate = true, 
                        lint = {
                            unknownAtRules = "ignore",
                        },
                    },
                    scss = {
                        validate = true,
                        lint = {
                            unknownAtRules = "ignore",
                        },
                    },
                    less = {
                        validate = true,
                        lint = {
                            unknownAtRules = "ignore",
                        },
                    },
                },
            })
            lspconfig.eslint.setup({
                capabilities = capabilities,
                settings = {
                    format = { enable = true },
                    codeAction = { disableRuleComment = { location = "separateLine" } },
                    packageManager = "npm",
                    formatters = {
                        prettier = {
                            command = "prettier",
                            args = { "--stdin-filepath", "%filepath" },
                        },
                    },
                },
            })
            lspconfig.tailwindcss.setup({
                capabilities = capabilities,
                filetypes = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
                root_dir = lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.ts", "postcss.config.js",
                    "postcss.config.ts"),
                settings = {
                    tailwindCSS = {
                        validate = true,
                        experimental = {
                            classRegex = {
                                { "class(?:Name)?=\"([^\"]*)\"" },                                                                   -- class="..."
                                { "class(?:Name)?=\\{`([^`]*)`\\}", "class(?:Name)?=\\{\\\"([^\\\"]*)\\\"\\}" },                     -- className={`...`} / {"..."}
                                { "clsx\\(([^\\)]*)\\)",            "classnames\\(([^\\)]*)\\)",              "cn\\(([^\\)]*)\\)" }, -- clsx()/cn()
                                { "tw`([^`]*)`",                    "tw=\"([^\"]*)\"" },                                             -- twin / tw=""
                                { "cva\\(([^\\)]*)\\)" },                                                                            -- cva({...})
                            },
                        },
                        colorDecorators = {
                            enable = true,
                        },
                    }

                }
            })
            --setup emmet language server
            lspconfig.emmet_language_server.setup({
                capabilities = capabilities,
                filetypes = { "html", "css", "javascript", "javascriptreact", "typescriptreact", },
            })

            -- lspconfig.tsserver.setup({
            --     capabilities = capabilities,
            -- })

            lspconfig.html.setup({
                capabilities = capabilities,
            })

            lspconfig.ts_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.gopls.setup({
                capabilities = capabilities,
                settings = {
                    gopls = {
                        diagnosticsDelay = "500ms",
                        experimentalPostfixCompletions = true, -- enable postfix completions
                    }
                }
            })
            lspconfig.clangd.setup({
                capabilities = capabilities,
            })
            lspconfig.csharp_ls.setup({
                capabilities = capabilities,
            })
            vim.keymap.set("n", "K", function()
              vim.lsp.buf.hover()
              vim.defer_fn(function()
                if Snacks and Snacks.image and Snacks.image.hover then
                  Snacks.image.hover()  -- shows image at a fixed spot / near cursor
                end
              end, 20)
            end, { desc = "LSP Hover + Snacks.image" })
            -- vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
            vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {})
        end,
    },
}
