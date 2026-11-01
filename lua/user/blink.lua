local M = {
  "saghen/blink.cmp",
  -- release tags ship a prebuilt fuzzy matcher; the main branch (v2) needs Nvim 0.12
  version = "1.*",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp",
      dependencies = { "rafamadriz/friendly-snippets" },
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    { "moyiz/blink-emoji.nvim" },
    { "milanglacier/minuet-ai.nvim" },
  },
}

function M.config()
  local icons = require "settings.icons"

  local sources = { "lazydev", "lsp", "path", "snippets", "buffer", "emoji" }
  -- minuet is also queried on manual <C-Space>, which fails with a curl error when no local ollama runs
  if vim.fn.executable "ollama" == 1 then
    table.insert(sources, "minuet")
  end

  require("blink.cmp").setup {
    keymap = {
      preset = "none",
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      -- manually ask the local LLM (minuet) for completions
      ["<A-y>"] = require("minuet").make_blink_map(),
    },
    appearance = {
      nerd_font_variant = "mono",
      kind_icons = vim.tbl_map(vim.trim, icons.kind),
    },
    completion = {
      -- minuet: avoid an LLM request every time insert mode is entered
      trigger = { prefetch_on_insert = false },
      menu = { border = "rounded", scrollbar = false },
      documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = "rounded" } },
      ghost_text = { enabled = false },
    },
    signature = { enabled = true, window = { border = "rounded" } },
    snippets = { preset = "luasnip" },
    sources = {
      default = sources,
      providers = {
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
        emoji = { name = "Emoji", module = "blink-emoji", score_offset = 15 },
        minuet = {
          name = "minuet",
          module = "minuet.blink",
          async = true,
          -- matches minuet's request_timeout (seconds)
          timeout_ms = 3000,
          score_offset = 50,
        },
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  }
end

return M
