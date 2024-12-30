require "nvchad.options"

-- add yours here!

local o = vim.opt
-- o.cursorlineopt ='both' -- to enable cursorline!
o.list = true
o.listchars:append {
  tab = "> ",
  space = "·",
  trail = "-",
  nbsp = "+",
  extends = "»",
  precedes = "«",
  eol = "↵"
}

-- Restore cursor position
local autocmd = vim.api.nvim_create_autocmd
autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
      line > 1
      and line <= vim.fn.line "$"
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})
