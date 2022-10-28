-- My Neovim config.
-- Author: Stephen Krider <skrider@berkeley.edu>
-- Neovim version: 8.0.0
vim.cmd [[packadd packer.nvim]]

packer = require("packer")
packer_util = require("packer.util")
packer.startup {
  function(use)
    use { "lewis6991/impatient.nvim", config = [[require('impatient')]] }
    use { "wbthomason/packer.nvim", opt = true }
    use { 
	"gelguy/wilder.nvim", 
	config = function()

	end
    }
  end,
  config = {
    max_jobs = 16,
    compile_path = packer_util.join_paths(vim.fn.stdpath("data"), "site", "lua", "packer_compiled.lua"),
  },
}
