local options = {
	number = true,
	swapfile = false,
	encoding = "utf-8",
	fileencoding = "utf-8",
	clipboard = "unnamedplus",
	autoindent = true,
	showmatch = true,
	hlsearch = true,
	incsearch = true,
	cursorline = true,
	ttyfast = true,
	splitright = true,
	tabstop = 2,
	shiftwidth = 2,
}


for k, v in pairs(options) do
	vim.opt[k] = v
end


