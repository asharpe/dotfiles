-- used in keys.lua
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

-- used in keys.lua
function showClipboard()
	jumpcut:popupMenu(hs.mouse.getAbsolutePosition())
end
