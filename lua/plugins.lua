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

	-- lsp
	use "neovim/nvim-lspconfig"
	use "williamboman/mason.nvim"
	use "williamboman/mason-lspconfig"

	-- autocompletion
	use "hrsh7th/nvim-cmp"
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/vim-vsnip"

	-- theme
	use "kyazdani42/nvim-web-devicons"
	use "kyazdani42/nvim-tree.lua"

	-- for git diff
	use "nvim-lua/plenary.nvim"
	use "sindrets/diffview.nvim"

	--nerdcommenter
	use "preservim/nerdcommenter"

	--indent-blank line
	use "lukas-reineke/indent-blankline.nvim"

	--barbar
	use "romgrk/barbar.nvim"

	-- wakatime
	use "wakatime/vim-wakatime"
end)

-- setups for nvim-tree
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
	open_on_setup = true,
	view = {
		hide_root_folder = true,
	},
	filters = {
		custom = {"^\\.git$"},
	}
})

-- setups for lsp
require("mason").setup()
require("mason-lspconfig").setup_handlers({ function(server)
	local opt = {
		automatic_installation = true,
		ensure_installed = {
			"cssls",
			"denols",
			"dockerls",
			"eslint",
			"gopls",
			"html",
			"tsserver",
			"sumneko_lua",
			"marksman",
			"jedi_language_server",
			"sqlls",
			"taplo",
			"tailwindcss",
			"terraformls",
			"yamlls"
		},
		capabilities = require("cmp_nvim_lsp").update_capabilities(
			vim.lsp.protocol.make_client_capabilities()
		)
	}
	require("lspconfig")[server].setup(opt)
end })

-- setups for autocompletion
local cmp = require "cmp"
cmp.setup({
	snippet = {
		expand = function(args)
			fn["vsnip#anonymous"](args.body)
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "vsnip" },
	},
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping.select_next_item(),
	}),
	experimental = {
		ghost_text = true,
	},
})

-- setups for indent_blankline
require("indent_blankline").setup({
	show_current_context = true,
	show_current_context_start = true,
})

