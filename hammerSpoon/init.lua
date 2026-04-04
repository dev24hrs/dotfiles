local hs = hs

hs.hotkey.bind({ "cmd", "ctrl" }, "r", function()
	hs.reload()
end)
hs.alert.show("Config loaded")

-- 1. 加载 PaperWM Spoon
local PaperWM = hs.loadSpoon("PaperWM")
local actions = PaperWM.actions.actions()

-- 2. 窗口过滤
--  osascript -e 'id of app "wechat"' 获得Bundle ID
local ignoreList = {
	"com.apple.systempreferences",
	"com.apple.finder",
	"com.apple.Notes",
	"com.tencent.xinWeChat",
	"com.tencent.Foxmail",
	"cn.com.10jqka.macstockPro", -- 同花顺
}
for _, app in ipairs(ignoreList) do
	PaperWM.window_filter:rejectApp(app)
end

-- 3. 自定义基础参数
PaperWM.window_gap = { top = 0, bottom = 0, left = 5, right = 5 }
PaperWM.window_ratios = { 0.6, 0.75, 0.9 } -- 循环切换的宽度比例
PaperWM.default_width = 0.9
PaperWM.infinite_loop_window = true

--- [配置] Modal 模式 ---
-- 设置快捷键为 Cmd + Enter 进入该模式
local wmModal = hs.hotkey.modal.new({ "cmd" }, "return")

-- --- [快捷键配置] ---

wmModal:bind({}, "h", nil, actions.focus_left)
wmModal:bind({}, "l", nil, actions.focus_right)

wmModal:bind({}, "n", nil, actions.swap_left)
wmModal:bind({}, "p", nil, actions.swap_right)

-- 调整窗口大小
wmModal:bind({}, "r", nil, actions.cycle_width) -- 循环预设宽度
wmModal:bind({}, "c", nil, actions.center_window) -- 居中窗口
wmModal:bind({}, "f", nil, actions.full_width) -- 全屏宽度


function wmModal:entered()
	hs.alert.show("modal start", 0.5)
end

--  只退出 Modal 模式
wmModal:bind({}, "escape", function()
	hs.alert.show("modal stop", 0.5)
	wmModal:exit()
end)
wmModal:bind({ "cmd" }, "return", function()
	hs.alert.show("modal stop", 0.5)
	wmModal:exit()
end)

-- 退出 modal（exited() 会自动调用 PaperWM:stop() 并恢复窗口）
wmModal:bind({}, "w", function()
	PaperWM:stop()
	wmModal:exit()
end)

PaperWM:start()
