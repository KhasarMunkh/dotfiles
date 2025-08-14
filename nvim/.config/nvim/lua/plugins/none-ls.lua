return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- Lua
        null_ls.builtins.formatting.stylua,
        -- JavaScript/TypeScript
        -- 
        null_ls.builtins.formatting.prettier.with({
            filetypes = {
                "javascript",
                "typescript",
                -- "javascriptreact",
                -- "typescriptreact",
                "css",
            },
          prefer_local = "node_modules/.bin", -- Use local prettier if available
        }),

        null_ls.builtins.formatting.clang_format,

        -- Golang
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.diagnostics.golangci_lint,
      },
    })
    local original_show = vim.diagnostic.show
    vim.diagnostic.show = function(namespace, bufnr, diagnostics, opts)
      if type(diagnostics) ~= "table" then
        -- fallback to original if diagnostics is nil or not a table
        return original_show(namespace, bufnr, diagnostics, opts)
      end

      local function deduplicate_diagnostics(diags)
        local seen, result = {}, {}
        for _, d in ipairs(diags) do
          local key = string.format("%d:%d:%s", d.lnum, d.col, d.message)
          if not seen[key] then
            seen[key] = true
            table.insert(result, d)
          end
        end
        return result
      end

      return original_show(namespace, bufnr, deduplicate_diagnostics(diagnostics), opts)
    end

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
