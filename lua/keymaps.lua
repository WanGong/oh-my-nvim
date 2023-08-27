-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Better paste
keymap("v", "p", "P", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Comment
keymap("n", "<leader>cc", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("x", "<leader>cc", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Lsp
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
keymap("n", "ff", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
keymap("n", "<C-f>", ":ClangdSwitchSourceHeader <cr>", opts)

-- buffers
keymap("n", "<leader>o", ":only<cr>", opts)
keymap("n", "<leader>w", ":w!<cr>", opts)
keymap("n", "<leader>q", ":q!<cr>", opts)
keymap("n", "<leader>x", ":x!<cr>", opts)
keymap("n", "<leader>-", ":sp<cr>", opts)
keymap("n", "<leader><Bslash>", ":vs<cr>", opts)
keymap("n", "<leader>t", ":tabedit<cr>", opts)

-- highlights
keymap("n", "zz", ":%s/\\s\\+$// <CR>", opts)

-- vim-mark
keymap("n", "mm", ":MarkClear <CR>", opts)

-- ctrlsf
keymap("n", "<leader>k", "<plug>CtrlSFCwordPath <cr>", opts)
keymap("n", "<leader>s", "<plug>CtrlSFPrompt ")
keymap("n", "cc", ":CtrlSFToggle<cr>", opts)

-- leaderf
keymap("n", "<leader>fb", ':<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>', opts)
keymap("n", "<leader>fr", ':<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>', opts)
keymap("n", "<leader>ft", ':<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>', opts)
keymap("n", "<leader>fl", ':<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>', opts)
