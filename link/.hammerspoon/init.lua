--hs.window.setFrameCorrectness = true
hs.window.animationDuration = 0

function maximise()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = 0
	f.y = 0
	f.w = max.w
	f.h = max.h

	win:setFrame(f)
end

meta = {"cmd", "alt", "ctrl"}

hs.hotkey.bind(meta, 'r', hs.reload)
hs.hotkey.bind(meta, 'f', maximise)
