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

	-- nvim-treesitter
	use "nvim-treesitter/nvim-treesitter"

	--indent-blank line
	use "lukas-reineke/indent-blankline.nvim"

	--barbar
	use "romgrk/barbar.nvim"

	-- wakatime
	use "wakatime/vim-wakatime"

	-- telescope
	use "nvim-telescope/telescope.nvim"

	-- nvim-jqx
	use "gennaro-tedesco/nvim-jqx"

	-- transparent
	use "xiyaowong/nvim-transparent"

	-- flutter
	use {
		"akinsho/flutter-tools.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" }
		}
	}
end)

-- setups for nvim-tree
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
	hijack_directories = {
		auto_open  = true,
	},
	filters = {
		custom = {"^\\.git$"},
	},
	git = {
		ignore = false,
	}
})

-- setups for flutter
require("flutter-tools").setup {
  debugger = {
    enabled = true,
  },
  outline = { auto_open = false },
  decorations = {
    statusline = { device = true, app_version = true },
  },
  widget_guides = { enabled = true, debug = true },
  dev_log = { enabled = false, open_cmd = "tabedit" },
  lsp = {
    color = {
      enabled = true,
      background = true,
      virtual_text = false,
    },
    settings = {
      showTodos = true,
      renameFilesWithClasses = "prompt",
    },
	}
}
-- setups for lsp
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({ function(server)
	local opt = {
		capabilities = require("cmp_nvim_lsp").default_capabilities(
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
		["Down"] = cmp.mapping.select_next_item(),
		["<Tab>"] = cmp.mapping.select_next_item(),
		["Up"] = cmp.mapping.select_prev_item(),
		["<CR>"] = cmp.mapping.confirm { select = true },
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

-- setups for treesitter
require("nvim-treesitter.configs").setup({
	indent = {
		enable = true,
	},
	highlight = {
		enable = true,
	}
})


-- setups for telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- setups for nvim-transparent
require("transparent").setup({
  extra_groups = { -- table/string: additional groups that should be cleared
    -- In particular, when you set it to 'all', that means all available groups

    -- example of akinsho/nvim-bufferline.lua
    "BufferLineTabClose",
    "BufferlineBufferSelected",
    "BufferLineFill",
    "BufferLineBackground",
    "BufferLineSeparator",
    "BufferLineIndicatorSelected",
  },
  exclude_groups = {}, -- table: groups you don't want to clear
})

