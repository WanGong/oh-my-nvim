local M = {
  "WanGong/vim-gutentags",
  event = "VeryLazy",
}

function M.config()
  vim.g.gutentags_project_root = { ".root", ".svn", ".git", ".hg", ".project", "package.json" }

  vim.g.gutentags_cache_dir = vim.fn.expand "~/.cache/tags"
  vim.g.gutentags_ctags_extra_args = { "-R", "--fields=+niazS", "--extras=+q", "--c++-kinds=+px", "--c-kinds=+px" }

  if not vim.fn.isdirectory(vim.g.gutentags_cache_dir) then
    vim.fn.mkdir(vim.g.gutentags_cache_dir)
  end

  vim.g.gutentags_ctags_exclude = {
    "*.git",
    "*.svn",
    "*.hg",
    "cache",
    "dist",
    "bin",
    "node_modules",
    "bower_components",
    "*-lock.json",
    "*.lock",
    "*.min.*",
    "CMakeLists.txt",
    "*.bak",
    "*.zip",
    "*.pyc",
    "*.class",
    "*.sln",
    "*.csproj",
    "*.csproj.user",
    "*.tmp",
    "*.cache",
    "*.vscode",
    "*.pdb",
    "*.pb",
    "*.exe",
    "*.dll",
    "*.bin",
    "*.mp3",
    "*.ogg",
    "*.flac",
    "*.swp",
    "*.swo",
    ".DS_Store",
    "*.plist",
    "*.bmp",
    "*.gif",
    "*.ico",
    "*.jpg",
    "*.png",
    "*.svg",
    "*.rar",
    "*.zip",
    "*.tar",
    "*.tar.gz",
    "*.tar.xz",
    "*.tar.bz2",
    "*.pdf",
    "*.doc",
    "*.docx",
    "*.ppt",
    "*.pptx",
    "*.xls",
  }

  vim.g.gutentags_trace = 0
  vim.g.gutentags_define_advanced_commands = 1
  vim.g.gutentags_enabled = 0

  local wk = require "which-key"
  wk.add {
    {
      "<leader>gg",
      function()
        vim.g.gutentags_enabled = 1 - vim.g.gutentags_enabled
        print(string.format("gutentags_enabled: %d", vim.g.gutentags_enabled))
      end,
      desc = "Togger gutentags",
    },
  }
end

return M

-- Add "'detach': 1," to the build_default_job_options in autoload/gutentags.vim
-- ref to:
-- https://github.com/ludovicchabant/vim-gutentags/issues/178
-- https://github.com/ludovicchabant/vim-gutentags/issues/167
-- https://github.com/ludovicchabant/vim-gutentags/issues/168
