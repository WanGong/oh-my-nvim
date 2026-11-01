-- Commenting is built into Nvim (`gc`/`gcc`, see :h commenting); this only makes it
-- treesitter-aware for embedded languages (e.g. JSX, Vue, markdown code blocks).
local M = {
  "JoosepAlviste/nvim-ts-context-commentstring",
  event = { "BufReadPost", "BufNewFile" },
}

function M.config()
  vim.g.skip_ts_context_commentstring_module = true
  ---@diagnostic disable-next-line: missing-fields
  require("ts_context_commentstring").setup {
    enable_autocmd = false,
  }

  local get_option = vim.filetype.get_option
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.filetype.get_option = function(filetype, option)
    return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
      or get_option(filetype, option)
  end
end

return M
