-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- only set clipboard if not in ssh, to make sure the OSC 52
-- integration works automatically. Requires Neovim >= 0.10.0
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard

opt.ignorecase = true
opt.smartcase = true
opt.autoindent = true
opt.smartindent = true
opt.smarttab = true
-- opt.shiftwidth = 4
opt.shiftround = true
opt.relativenumber = true
-- opt.tabstop = 4
-- opt.softtabstop = 4
opt.termguicolors = true
opt.expandtab = true
