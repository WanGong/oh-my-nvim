local M = {
  "Yggdroot/LeaderF",
  lazy = false,
  build = ":LeaderfInstallCExtension",
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
