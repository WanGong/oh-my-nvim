local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local out = vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({ { "Failed to clone lazy.nvim:\n", "ErrorMsg" }, { out } }, true, {})
    return
  end
end
vim.opt.rtp:prepend(lazypath)

-- example using a list of specs with the default options
vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct

-- load lazy
require("lazy").setup("user", {
  install = { colorscheme = { require("user.colorscheme").colorscheme } },
  defaults = { lazy = true },
  ui = { wrap = true },
  change_detection = { enabled = true },
  debug = false,
  rocks = { enabled = false },
  performance = {
    rtp = {
      -- lazy.nvim picks <prefix>/lib64/nvim whenever lib64 exists, which drops the bundled parsers in <prefix>/lib/nvim
      paths = { vim.fn.fnamemodify(vim.v.progpath, ":p:h:h") .. "/lib/nvim" },
      disabled_plugins = {
        -- "gzip", -- Plugin for editing compressed files.
        -- "matchit", -- What is it?
        --  "matchparen", -- Plugin for showing matching parens
        --  "netrwPlugin", -- Handles file transfers and remote directory listing across a network
        --  "tarPlugin", -- Plugin for browsing tar files
        --  "tohtml", -- Converting a syntax highlighted file to HTML
        --  "tutor", -- Teaching?
        --  "zipPlugin", -- Handles browsing zipfiles
      },
    },
  },
})
