local vim = vim

local execute = vim.api.nvim_command
local fn = vim.fn

-- ensure that packer is installed
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.vim"
if fn.empty(fn.glob(install_path)) > 0 then
	execute("!git clone https://github.com/wbthomason/packer.nvim "..install_path)
	execute "packadd packer.nvim"
end

vim.cmd("packadd packer.nvim")

local packer = require"packer"
local util = require"packer.util"

packer.init({
	package_root = util.join_paths(vim.fn.stdpath("data"), "site", "pack")
})


packer.startup(function()
	local use = use
	use "wbthomason/packer.nvim"

	-- color
	use "EdenEast/nightfox.nvim"

	-- theme
	use "kyazdani42/nvim-web-devicons"
	use "kyazdani42/nvim-tree.lua"

	-- wakatime
	use "wakatime/vim-wakatime"
end)


-- setups for nvim-tree
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup()

