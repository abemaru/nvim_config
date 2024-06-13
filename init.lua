-- code from lazy.nvim
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

-- installation of plugins
require("lazy").setup({
	{ "nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function ()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"lua", "vim", "vimdoc", "query", "javascript", "html", "css",
					"go", "json", "python", "scss", "sql", "terraform", "typescript",
					"vue", "xml", "yaml"
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end
	},

	-- colortheme plugins
	{ "EdenEast/nightfox.nvim", lazy = false },

	-- lsp plugins
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim", },
	{ "williamboman/mason-lspconfig.nvim" },

	-- code completion plugins
	{ 
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
		},
	},
})

-- settings for lsp
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")


