vim.diagnostic.config({
  virtual_text = {
    prefix = "●",      -- "" keeps the default ▸  |  "●" looks clean
    spacing = 2,
    source  = "if_many", -- show the LSP name if >1 client
  },
  signs = true,          -- ▌ gutter icons
  underline = true,      -- colored underline
  update_in_insert = false, -- don’t flicker while typing
  severity_sort = true,
})
