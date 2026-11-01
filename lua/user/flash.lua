-- replaces hop.nvim (jump with labels) and clever-f.vim (repeat f/t by pressing it again)
local M = {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    modes = {
      -- f/F/t/T show labels across lines; press the same key again (or ; ,) for the next match
      char = { enabled = true, multi_line = true },
    },
  },
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter select" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter search" },
    { "<C-s>", mode = "c", function() require("flash").toggle() end, desc = "Toggle flash in / search" },
  },
}

return M
