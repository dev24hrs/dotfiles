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
	"com.netease.163music",
	"cn.com.10jqka.macstockPro",
}
for _, app in ipairs(ignoreList) do
	PaperWM.window_filter:rejectApp(app)
end

-- 3. 自定义基础参数
PaperWM.window_gap = { top = 0, bottom = 0, left = 5, right = 5 }
PaperWM.window_ratios = { 0.9, 0.5 } -- 循环切换的宽度比例

--- [新窗口] 自动 0.9 比例 ---
local function subscribeWindowCreated()
	PaperWM.window_filter:subscribe(hs.window.filter.windowCreated, function(win)
		local retryCount = 0
		local maxRetries = 5

		local function adjustNewWindow()
			if not win or not win:isVisible() then
				return
			end

			local screen = win:screen()
			if not screen then
				if retryCount < maxRetries then
					retryCount = retryCount + 1
					hs.timer.doAfter(0.2, adjustNewWindow)
				end
				return
			end

			hs.timer.doAfter(0.3, function()
				if not win or not win:isVisible() then
					return
				end
				local canvas = PaperWM.windows.getCanvas(screen)
				local gap = (PaperWM.windows.getGap("left") + PaperWM.windows.getGap("right")) / 2
				local target_width = PaperWM.window_ratios[1] * (canvas.w + gap) - gap
				local frame = win:frame()
				frame.x = frame.x + ((frame.w - target_width) / 2)
				frame.w = target_width
				PaperWM.windows.moveWindow(win, frame)
				local spaces = hs.spaces.windowSpaces(win)
				if spaces and spaces[1] then
					PaperWM:tileSpace(spaces[1])
				end
			end)
		end
		adjustNewWindow()
	end)
end

subscribeWindowCreated()

--- [配置] Modal 模式 ---
-- 设置快捷键为 Cmd + Enter 进入该模式
local wmModal = hs.hotkey.modal.new({ "cmd" }, "return")

local paperwmRunning = false

function wmModal:entered()
	if not paperwmRunning then
		PaperWM:start()
		subscribeWindowCreated()
		paperwmRunning = true
	end
	hs.alert.show("进入 PaperWM 模式", 0.5)
end

function wmModal:exited()
	hs.alert.show("退出 PaperWM 模式", 0.5)
end

--- [快捷键配置] ---

wmModal:bind({}, "h", nil, actions.focus_left)
wmModal:bind({}, "l", nil, actions.focus_right)
-- wmModal:bind({}, "k", nil, actions.focus_up)
-- wmModal:bind({}, "j", nil, actions.focus_down)

-- 交换窗口位置 (Shift + h/j/k/l)
wmModal:bind({ "shift" }, "h", nil, actions.swap_left)
wmModal:bind({ "shift" }, "l", nil, actions.swap_right)
-- wmModal:bind({ "shift" }, "k", nil, actions.swap_up)
-- wmModal:bind({ "shift" }, "j", nil, actions.swap_down)

-- 调整窗口大小
wmModal:bind({}, "r", nil, actions.cycle_width) -- 循环预设宽度
wmModal:bind({}, "c", nil, actions.center_window) -- 居中窗口
wmModal:bind({}, "f", nil, actions.full_width) -- 全屏宽度

-- 退出 Modal 模式的按键
wmModal:bind({}, "escape", function()
	wmModal:exit()
end)
wmModal:bind({ "cmd" }, "return", function()
	wmModal:exit()
end)

-- 在 PaperWM 接管之前保存所有窗口的原始位置和大小
local originalFrames = {}
for _, win in ipairs(hs.window.filter.new():getWindows()) do
	if win:isStandard() then
		originalFrames[win:id()] = win:frame()
	end
end

wmModal:bind({}, "w", "恢复Macos默认布局", function()
	PaperWM:stop()
	paperwmRunning = false
	local windows = hs.window.filter.new():getWindows()
	for _, win in ipairs(windows) do
		if win:isStandard() then
			local saved = originalFrames[win:id()]
			if saved then
				win:setFrame(saved)
			else
				win:centerOnScreen(nil, true)
			end
		end
	end
	wmModal:exit()
	hs.alert.show("PaperWM 已停止，窗口已恢复原始位置")
end)

PaperWM:start()
paperwmRunning = true
