-- 1. Telescope Compatibility Patch (Must run first)
if vim.treesitter.language and not vim.treesitter.ft_to_lang then
  vim.treesitter.ft_to_lang = vim.treesitter.language.get_lang
end

-- 2. Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 3. Core options
vim.opt.clipboard = "unnamedplus"  -- yank/paste goes to system clipboard
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- 4. Set global map leaders (Must happen BEFORE loading plugins)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 4. Initialize Lazy and point it to your plugins directory
require("lazy").setup("plugins")
