-- https://github.com/wbthomason/packer.nvim

-- awesome-neovim: neovim plugins colletions
-- https://github.com/rockerBOO/awesome-neovim

-- use usage
-- use {
--   "myusername/example",        -- The plugin location string
--   -- The following keys are all optional
--   disable = boolean,           -- Mark a plugin as inactive
--   as = string,                 -- Specifies an alias under which to install the plugin
--   installer = function,        -- Specifies custom installer. See "custom installers" below.
--   updater = function,          -- Specifies custom updater. See "custom installers" below.
--   after = string or list,      -- Specifies plugins to load before this plugin. See "sequencing" below
--   rtp = string,                -- Specifies a subdirectory of the plugin to add to runtimepath.
--   opt = boolean,               -- Manually marks a plugin as optional.
--   bufread = boolean,           -- Manually specifying if a plugin needs BufRead after being loaded
--   branch = string,             -- Specifies a git branch to use
--   tag = string,                -- Specifies a git tag to use. Supports "*" for "latest tag"
--   commit = string,             -- Specifies a git commit to use
--   lock = boolean,              -- Skip updating this plugin in updates/syncs. Still cleans.
--   run = string, function, or table, -- Post-update/install hook. See "update/install hooks".
--   requires = string or list,   -- Specifies plugin dependencies. See "dependencies".
--   rocks = string or list,      -- Specifies Luarocks dependencies for the plugin
--   config = string or function, -- Specifies code to run after this plugin is loaded.
--   -- The setup key implies opt = true
--   setup = string or function,  -- Specifies code to run before this plugin is loaded.
--   -- The following keys all imply lazy-loading and imply opt = true
--   cmd = string or list,        -- Specifies commands which load this plugin. Can be an autocmd pattern.
--   ft = string or list,         -- Specifies filetypes which load this plugin.
--   keys = string or list,       -- Specifies maps which load this plugin. See "Keybindings".
--   event = string or list,      -- Specifies autocommand events which load this plugin.
--   fn = string or list          -- Specifies functions which load this plugin.
--   cond = string, function, or list of strings/functions,   -- Specifies a conditional test to load this plugin
--   module = string or list      -- Specifies Lua module names for require. When requiring a string which starts
--                                -- with one of these module names, the plugin will be loaded.
--   module_pattern = string/list -- Specifies Lua pattern of Lua module names for require. When requiring a string which matches one of these patterns, the plugin will be loaded.
-- }

-- use_rocks: install lua lib

return require('packer').startup(function(use)

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- 中文版vimdoc
  use "syscall0x80/vimdoccn"

  -- 主题
  use "LunarVim/darkplus.nvim"
  use "ellisonleao/gruvbox.nvim"
  use "rebelot/kanagawa.nvim"

  -- nvim-colorizer | 为代表颜色的文本着色
  use "NvChad/nvim-colorizer.lua"

  -- editorconfig
  use "gpanders/editorconfig.nvim"

  -- coc
  use { "neoclide/coc.nvim", branch = "release" }

  use "puremourning/vimspector"

  -- lualine | 状态栏
  use {
    "nvim-lualine/lualine.nvim",
    config = function ()
      require("user.conf.lualine")
    end
  }

  -- Comment | 注释
  use {
    "numToStr/Comment.nvim",
    config = function()
      require("user.conf.comment")
    end,
  }

  -- telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    tag = "0.1.0",
    config = function()
      require("user.conf.telescope")
    end,
  }
  use "nvim-telescope/telescope-ui-select.nvim"
  use "nvim-telescope/telescope-live-grep-args.nvim"
  use {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
  }
  use "fannheyward/telescope-coc.nvim"

  -- 工作空间管理
  use {
    "natecraddock/workspaces.nvim",
    config = function()
      require("user.conf.workspaces")
    end
  }

end)
