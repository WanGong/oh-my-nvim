local M = {
  "folke/which-key.nvim",
  dependencies = {
    {
      "echasnovski/mini.icons",
      event = "VeryLazy",
    },
  },
}

function M.config()
  local which_key = require "which-key"

  which_key.setup {
    delay = 1500,
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = false,
        text_objects = true,
        windows = false,
        nav = false,
        z = true,
        g = false,
      },
    },
    win = {
      border = "rounded",
      padding = { 1, 1, 1, 1 },
    },
    show_help = false,
    show_keys = false,
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  }

  local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
  }

  local mappings = {
    { "<leader>;", "<cmd>tabnew | terminal<CR>", desc = "Term" },
    -- { "<leader>T", group = "Treesitter" },
    -- { "<leader>a", group = "Tab" },
    -- { "<leader>aN", "<cmd>tabnew %<cr>", desc = "New Tab" },
    -- { "<leader>ah", "<cmd>-tabmove<cr>", desc = "Move Left" },
    -- { "<leader>al", "<cmd>+tabmove<cr>", desc = "Move Right" },
    -- { "<leader>an", "<cmd>$tabnew<cr>", desc = "New Empty Tab" },
    -- { "<leader>ao", "<cmd>tabonly<cr>", desc = "Only" },
    -- { "<leader>b", group = "Buffers" },
    -- { "<leader>d", group = "Debug" },
    -- { "<leader>f", group = "Find" },
    -- { "<leader>g", group = "Git" },
    -- { "<leader>h", "<cmd>nohlsearch<CR>", desc = "NOHL" },
    -- { "<leader>l", group = "LSP" },
    -- { "<leader>p", group = "Plugins" },
    -- { "<leader>q", "<cmd>confirm q<CR>", desc = "Quit" },
    -- { "<leader>t", group = "Test" },
    { "<leader>v", "<cmd>vsplit<CR>", desc = "Split" },
  }

  which_key.add(mappings, opts)
end

return M
