import "CoreLibs/crank"

local gfx <const> = playdate.graphics
local display <const> = playdate.display

apps.display = {
	name = "Display",
	key = "display",
	description = "Information about the game and SDK",
}

function apps.display.init()
	-- display.setInverted(false)
end

function apps.display.denit()
	-- display.setInverted(false)
end

function apps.display.update()
	if playdate.buttonJustPressed(playdate.kButtonB) then
		sfx.play(sfx.back)
		apps.switchTo(apps.mainMenu)
		return
	end

	if playdate.buttonJustPressed(playdate.kButtonA) then
		display.setInverted(not display.getInverted())
	end

	local scale = display.getScale()

	if playdate.buttonJustPressed(playdate.kButtonRight) then
		scale *= 2
	end

	if playdate.buttonJustPressed(playdate.kButtonLeft) then
		scale /= 2
	end

	scale = util.clamp(scale, 1, 8)
	display.setScale(scale)

	if playdate.buttonJustPressed(playdate.kButtonUp) then
		display.setFlipped(true, true)
	end

	if playdate.buttonJustPressed(playdate.kButtonDown) then
		display.setFlipped(false, false)
	end

	local crankTicks = playdate.getCrankTicks(12)
	if crankTicks ~= 0 then
		local refreshRate = display.getRefreshRate()
		refreshRate = refreshRate + crankTicks
		refreshRate = util.clamp(refreshRate, 1, 50)
		display.setRefreshRate(refreshRate)
	end

	gfx.clear()
	gfx.setFont(fonts.medium)
	gfx.drawText("Display", 6, 6)
	gfx.setFont(fonts.small)

	gfx.drawText("Refresh Rate (Set): " .. tostring(display.getRefreshRate()), 6, 34);
	gfx.drawText("Refresh Rate (Actual): " .. tostring(playdate.getFPS()), 6, 52);

	local width, height = display.getSize()
	gfx.drawText("Size: " .. width .. "x" .. height, 6 , 70);
	gfx.drawText("Scale: " .. display.getScale(), 6 , 88);
	gfx.drawText("Inverted: " .. tostring(display.getInverted()), 6 , 106);
	local offsetX, offsetY = display.getOffset()
	gfx.drawText("Offset: " .. offsetX .. "x" .. offsetY, 6 , 124);


	gfx.drawText("Crank to change FPS", 6 , 160);
	gfx.drawText("Press (A) to toggle inversion", 6 , 178);
	gfx.drawText("Left/Right to toggle scale", 6 , 196);
	gfx.drawText("Up/Downto flip", 6 , 214);

	-- set scale
	-- set flipped
end

