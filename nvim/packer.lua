local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_boostrap = ensure_packer()

return require('packer').startup(function(use)
--  use {
--    "nvim-treesitter/nvim-treesitter",
--    event = "BufEnter",
--    run = ":TSUpdate",
--    config = [[require('config.treesitter')]],
--  }

  if packer_boostrap then
    require('packer').sync()
  end
end)
