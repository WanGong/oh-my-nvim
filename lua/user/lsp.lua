-- Brief aside: **What is LSP?**
--
-- LSP is an initialism you've probably heard, but might not understand what it is.
--
-- LSP stands for Language Server Protocol. It's a protocol that helps editors
-- and language tooling communicate in a standardized fashion.
--
-- In general, you have a "server" which is some tool built to understand a particular
-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
-- processes that communicate with some "client" - in this case, Neovim!
--
-- LSP provides Neovim with features like:
--  - Go to definition
--  - Find references
--  - Autocompletion
--  - Symbol Search
--  - and more!
--
-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
-- and elegantly composed help section, `:help lsp-vs-treesitter`

local M = {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    {
      "saghen/blink.cmp",
    },
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
}

M.toggle_inlay_hints = function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }, { bufnr = bufnr })
end

function M.config()
  local function lsp_keymaps(bufnr)
    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
    end
    map("gD", vim.lsp.buf.declaration, "Goto declaration")
    map("gd", vim.lsp.buf.definition, "Goto definition")
    map("K", function() vim.lsp.buf.hover() end, "Hover")
    map("gI", vim.lsp.buf.implementation, "Goto implementation")
    map("gr", vim.lsp.buf.references, "References")
    map("gl", vim.diagnostic.open_float, "Line diagnostics")
    map("<leader>li", "<cmd>LspInfo<cr>", "LSP info")
    map("<leader>lI", "<cmd>Mason<cr>", "Mason")
    map("<leader>la", vim.lsp.buf.code_action, "Code action")
    map("<leader>lj", function() vim.diagnostic.jump { count = 1, float = true } end, "Next diagnostic")
    map("<leader>lk", function() vim.diagnostic.jump { count = -1, float = true } end, "Prev diagnostic")
    map("<leader>lr", vim.lsp.buf.rename, "Rename")
    map("<leader>ls", function() vim.lsp.buf.signature_help() end, "Signature help")
    map("<leader>lq", vim.diagnostic.setloclist, "Diagnostics to loclist")
    map("<leader>lh", M.toggle_inlay_hints, "Toggle inlay hints")
  end

  -- LspAttach instead of a per-server on_attach so servers enabled by mason-lspconfig get the keymaps too
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      lsp_keymaps(args.buf)
      if client and client:supports_method("textDocument/inlayHint", args.buf) then
        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
      end
    end,
  })

  vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })

  local servers = require "user.lspsettings.enabled_servers"
  for _, server in ipairs(servers) do
    server = vim.split(server, "@")[1]

    local require_ok, conf_opts = pcall(require, "user.lspsettings." .. server)
    if require_ok then
      vim.lsp.config(server, conf_opts)
    end
    vim.lsp.enable(server)
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.HINT] = "󰌵",
        [vim.diagnostic.severity.INFO] = "",
      },
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = true,
      header = "",
      prefix = "",
      suffix = "",
    },
  }

  vim.diagnostic.config(config)

  local hover = vim.lsp.buf.hover
  vim.lsp.buf.hover = function(opts)
    return hover(vim.tbl_extend("keep", opts or {}, { border = "rounded" }))
  end

  local signature_help = vim.lsp.buf.signature_help
  vim.lsp.buf.signature_help = function(opts)
    return signature_help(vim.tbl_extend("keep", opts or {}, { border = "rounded" }))
  end
end

return M
