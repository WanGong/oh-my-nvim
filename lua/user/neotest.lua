local M = {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    -- general tests: neotest-vim-test can't reach vim-test from neotest's subprocess, so
    -- vim-test is used directly through its commands for languages without an adapter
    { "vim-test/vim-test", cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" } },
    -- language specific tests
    "marilari88/neotest-vitest",
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-plenary",
    "lawrence-laz/neotest-zig",
    "rcasia/neotest-bash",
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>tt", "<cmd>lua require'neotest'.run.run()<cr>", desc = "Test Nearest" },
    { "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Test File" },
    { "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "Debug Test" },
    { "<leader>ts", "<cmd>lua require('neotest').run.stop()<cr>", desc = "Test Stop" },
    { "<leader>ta", "<cmd>lua require('neotest').run.attach()<cr>", desc = "Attach Test" },
  },
}

function M.config()

  ---@diagnostic disable: missing-fields
  require("neotest").setup {
    adapters = {
      require "neotest-python" {
        dap = { justMyCode = false },
      },
      require "neotest-vitest",
      require "neotest-zig",
      require "neotest-plenary",
      require "neotest-bash",
    },
  }
end

return M
