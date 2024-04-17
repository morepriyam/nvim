vim.g.mapleader = " "
vim.keymap.set("n", "<leader>v", vim.cmd.Ex)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

local plugins = {
{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
{
   'nvim-telescope/telescope.nvim', tag = '0.1.6',
   -- or                              , branch = '0.1.x',
   dependencies = { 'nvim-lua/plenary.nvim' }
}
}

local opts = {}

require("lazy").setup(plugins, opts)

--Telescope
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

-- Colours
require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"
