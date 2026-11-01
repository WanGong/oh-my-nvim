-- sticky header showing the enclosing function / class at the top of the window
local M = {
  "nvim-treesitter/nvim-treesitter-context",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    max_lines = 3,
    multiline_threshold = 1,
  },
  keys = {
    -- not [c: that's the built-in "previous change" motion in diff mode
    { "[x", function() require("treesitter-context").go_to_context(vim.v.count1) end, desc = "Jump to context" },
  },
}

return M
