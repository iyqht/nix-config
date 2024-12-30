require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- tmux navigate
map("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Window left" })
map("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Window right" })
map("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "window down" })
map("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Window up" })
map("n", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", { desc = "Previous window" })

map({"n", "v" }, ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")


-- Zen mode
map({ "n", "v" }, "<leader>z", "<cmd>ZenMode<cr>", { desc = "Zen Mode" })
