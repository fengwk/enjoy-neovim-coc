function _G._theme_changed(cs)
  if cs == "gruvbox" then
    require "user.conf.lualine".setup({ options = { theme = "gruvbox" } })
  elseif cs == "my-darkplus" or cs == "darkplus" or cs == "vscode" then
    require "user.conf.lualine".setup({ options = { theme = "onedark" } })
  else
    require "user.conf.lualine".setup({ options = { theme = "auto" } })
  end
end

vim.cmd[[
augroup user_theme
  autocmd!
  " autocmd ColorSchemePre * colorscheme default
  autocmd ColorScheme * lua _G._theme_changed(vim.fn.expand("<amatch>"))
augroup end
]]

vim.cmd "colorscheme kanagawa"
