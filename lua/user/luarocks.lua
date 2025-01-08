local M = {
  "camspiers/luarocks",
  priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
}

M.opts = {
  rocks = { "fzy", "pathlib.nvim ~> 1.0" }, -- specifies a list of rocks to install
  -- luarocks_build_args = { "--with-lua=/my/path" }, -- extra options to pass to luarocks's configuration script
}

function M.config() end

return M
