local gfx <const> = playdate.graphics

apps.serial = {
	name = "Serial",
	key = "serial",
	description = "Send messages to your Playdate",
}

local serial = apps.serial
local lastMessage = nil

function serial.update()
	if playdate.buttonJustPressed(playdate.kButtonB) then
		sfx.play(sfx.back)
		apps.switchTo(apps.mainMenu)
		return
	end

	gfx.clear()
	gfx.setFont(fonts.medium)
	gfx.drawText("Serial", 12, 12)
	gfx.setFont(fonts.small)

	if lastMessage then
		gfx.drawText(lastMessage, 12, 82)
	end

	gfx.drawText("Send a message with !msg in the\nSimulator console", 12, 120);
	gfx.drawText("Use *scene:someScene* to switch to a scene", 12, 180);
end

function playdate.serialMessageReceived(message)
	sfx.play(sfx.select)
	lastMessage = message

	if string.find(message, "scene:") == 1 then
		local scene = string.sub(message, 7)
		print("Switching to " .. scene .. " from serialMessageReceived")
		apps.switchTo(scene)
	end
end
