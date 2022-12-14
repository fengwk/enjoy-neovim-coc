-- 自动切换输入法
local utils = require "user.utils"
local state_filename = utils.fs_concat({  vim.fn.stdpath("cache"), "im-switch" , "state" })

-- 自动切换fcitx5输入法
local function auto_switch_fcitx5(mode)
  if mode == "in" then -- 进入插入模式
    local state = utils.read_file(state_filename) -- 读取状态值
    if state == "2" then -- 2说明退出前是active的，应该被重置
      utils.exec_cmd("fcitx5-remote -o")
    end
  else
    -- 退出插入模式时将将当前状态记录下来，并切回不活跃
    utils.ensure_mkdir(vim.fn.fnamemodify(state_filename, ":h"))
    utils.exec_cmd("fcitx5-remote > " .. state_filename)
    utils.exec_cmd("fcitx5-remote -c")
  end
end

-- 自动切换微软拼音输入法
local function auto_switch_micro_pinyin(mode)
  if mode == "in" then -- 进入插入模式
    local state = utils.read_file(state_filename)
    if state == "zh" then -- zh说明退出前是中文的，应该被重置
      utils.exec_cmd("im-switch-x64.exe zh")
    end
  else
    -- 退出插入模式时将将当前状态记录下来，并切回英文
    utils.ensure_mkdir(vim.fn.fnamemodify(state_filename, ":h"))
    utils.exec_cmd("im-switch-x64.exe en > " .. state_filename)
  end
end

-- wsl版本，使用cmd.exe会对性能有一定的影响
-- cmd.exe参考：https://www.cnblogs.com/baby123/p/11459316.html
local function auto_switch_micro_pinyin_wsl(mode)
  if mode == "in" then -- 进入插入模式
    local state = utils.read_file(state_filename)
    if state == "zh" then -- zh说明退出前是中文的，应该被重置
      utils.exec_cmd("cmd.exe /C \"im-switch-x64.exe zh")
    end
  else
    -- 退出插入模式时将将当前状态记录下来，并切回英文
    utils.ensure_mkdir(vim.fn.fnamemodify(state_filename, ":h"))
    utils.exec_cmd("cmd.exe /C im-switch-x64.exe en > " .. state_filename)
  end
end

-- 自动切换输入法
local function auto_switch_im(mode)
  if utils.os_name == "win" then
    return auto_switch_micro_pinyin(mode)
  else
    if utils.os_name == "wsl" then
      return auto_switch_micro_pinyin_wsl(mode)
    else
      return auto_switch_fcitx5(mode)
    end
  end
end

-- 在相应的时机自动进行函数调用
-- vim自动命令参考：http://yyq123.github.io/learn-vim/learn-vi-49-01-autocmd.html
-- 查看当前文档类型
-- :echo &filetype
-- :help api-autocmd
vim.api.nvim_create_augroup("user_im_switch", { clear = true })
vim.api.nvim_create_autocmd(
  { "InsertLeave" },
  { group = "user_im_switch", pattern = "*", callback = function()
    auto_switch_im("out")
  end}
)
vim.api.nvim_create_autocmd(
  { "InsertEnter" },
  -- 仅对指定类型的文件进行中文重置
  { group = "user_im_switch", pattern = "*", callback = function()
    local ft = utils.get_current_filetype()
    if ft == "markdown" then
      auto_switch_im("in")
    end
  end}
)
-- windows切换输入法成本较高，降低切换频率
if utils.os_name ~= "win" then
  vim.api.nvim_create_autocmd(
    { "BufCreate" },
    { group = "user_im_switch", pattern = "*", callback = function() auto_switch_im("out") end }
  )
  vim.api.nvim_create_autocmd(
    { "BufEnter" },
    { group = "user_im_switch", pattern = "*", callback = function() auto_switch_im("out") end }
  )
  vim.api.nvim_create_autocmd(
    { "BufLeave" },
    { group = "user_im_switch", pattern = "*", callback = function() auto_switch_im("out") end }
  )
end