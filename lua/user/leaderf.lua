local M = {
  "Yggdroot/LeaderF",
  lazy = false,
  -- not :LeaderfInstallCExtension: its install.sh compiles with the system `python3`, whose
  -- headers may be missing and whose ABI differs from the provider (g:python3_host_prog, see pyvenv.lua)
  build = function(plugin)
    local python = vim.g.python3_host_prog or "python3"
    local out = vim.system(
      { python, "setup.py", "build", "--build-lib", "../python" },
      { cwd = plugin.dir .. "/autoload/leaderf/fuzzyMatch_C", text = true }
    ):wait()
    if out.code ~= 0 then
      error("LeaderF C extension build failed:\n" .. out.stdout .. out.stderr)
    end
  end,
}

function M.config()
  local wk = require "which-key"
  wk.add {
    { "<leader>fb", ':<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>', desc = "Search buffer" },
    { "<leader>fr", ':<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>', desc = "Search mru" },
    { "<leader>ft", ':<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>', desc = "Search tag in cur buffer " },
    { "<leader>fl", ':<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>', desc = "Search line in cur buffer" },
    { "<leader>fk", ":Leaderf! rg --stayOpen --no-auto-preview <C-R><C-W> <CR>", desc = "Search word under cursor" },
    { "<leader>fs", ":Leaderf! rg --stayOpen --no-auto-preview <Space>", desc = "Search with input" },
  }
end

return M
