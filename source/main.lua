import "CoreLibs/graphics"
import "CoreLibs/object"
import "CoreLibs/timer"
import "CoreLibs/ui"
import 'CoreLibs/nineslice'

import "util"
import "meta"
import "screen"
import "apps"
import "sfx"
import "fonts"

local gfx <const> = playdate.graphics
local fonts <const> = fonts
local meta <const> = meta
local apps <const> = apps

apps.init()
gfx.setFont(fonts.small)

local menu = playdate.getSystemMenu()

menu:addMenuItem("main menu", function()
		apps.switchTo(apps.mainMenu)
end)

function playdate.update()
	playdate.timer:updateTimers()

	apps.current.update()

	if meta.isDebug then
		playdate.drawFPS(screen.width - 24, 12)
	end
end
