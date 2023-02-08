 -- Добавляем Packer как пакет в Neovim
vim.cmd [[packadd packer.nvim]]

-- Используем данный коллбэк как список для плагинов
return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'morhetz/gruvbox'
	use {'neoclide/coc.nvim', branch = 'release'}
end)
