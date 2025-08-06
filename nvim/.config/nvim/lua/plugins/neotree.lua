return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",      -- icons
    "MunifTanjim/nui.nvim",
  },

  -- load on demand: <C-n> or :Neotree
  keys = {
    { "<C-n>", function()
        vim.cmd("Neotree filesystem reveal float")
      end,
      desc = "Neo-tree: toggle"
    },
  },

  config = function()
    require("neo-tree").setup({
      event_handlers = {
        {
          event = "file_opened",
          handler = function(_)
            -- close the tree when you open a file
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
      ---- put any other neo-tree options here
    })
  end,
}
