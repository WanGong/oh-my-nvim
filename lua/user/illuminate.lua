local M = {
  "RRethy/vim-illuminate",
  event = "VeryLazy",
}

function M.config()
  local illuminate = require "illuminate"
  vim.g.Illuminate_ftblacklist = { "alpha", "NvimTree" }
  vim.api.nvim_set_keymap(
    "n",
    "<a-n>",
    '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>',
    { noremap = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<a-p>",
    '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>',
    { noremap = true }
  )

  illuminate.configure {
    providers = {
      "lsp",
      "treesitter",
      "regex",
    },
    delay = 200,
    filetypes_denylist = {
      "DiffviewFiles",
      "DressingInput",
      "DressingSelect",
      "Jaq",
      "NeogitCommitMessage",
      "NeogitStatus",
      "NvimTree",
      "Outline",
      "TelescopePrompt",
      "Trouble",
      "alpha",
      "dirvish",
      "fugitive",
      "harpoon",
      "lazy",
      "lir",
      "mason",
      "minifiles",
      "neogitstatus",
      "netrw",
      "oil",
      "packer",
      "qf",
      "spectre_panel",
      "toggleterm",
    },
    filetypes_allowlist = {},
    modes_denylist = {},
    modes_allowlist = {},
    providers_regex_syntax_denylist = {},
    providers_regex_syntax_allowlist = {},
    under_cursor = true,
  }
end

return M
