vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2

vim.o.termguicolors = true
-- vim.cmd'colorscheme yourfavcolorscheme'

require'colorizer'.setup()
require('keybindings')
require('packer').startup(function()
  use { 'rainbowhxch/accelerated-jk.nvim' }
  use 'wbthomason/packer.nvim'
  use 'tomasr/molokai'
  use {
    'vimwiki/vimwiki',
    config = function()
      vim.g.vimwiki_list = {
        {
          path = '~/',
          syntax = 'markdown',
          ext = '.md',
        }
      }
      vim.g.vimwiki_ext2syntax = {
        ['.md'] = 'markdown',
        ['.markdown'] = 'markdown',
        ['.mdown'] = 'markdown',
      }
    end
  }
end)
vim.g.colors_name = 'molokai'
if vim.g.vscode then
  -- VSCode Extension
else
  -- ordinary Neovim
end

