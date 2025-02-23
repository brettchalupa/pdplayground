import "CoreLibs/string"

local gfx <const> = playdate.graphics

apps.uuid = {
	name = "UUID",
	key = "uuid",
	description = "Information about the console",
}

local uuid = apps.uuid
local currentUUID = nil

function uuid.update()
	if playdate.buttonJustPressed(playdate.kButtonB) then
		sfx.play(sfx.back)
		apps.switchTo(apps.mainMenu)
		return
	end

	gfx.clear()
	gfx.setFont(fonts.medium)
	gfx.drawText("UUID", 12, 12)
	gfx.setFont(fonts.small)
	gfx.drawText(currentUUID, 12, 82);
	gfx.drawText("Press (A) to generate a new unique identifier", 12, 150);
end

function uuid.init()
	uuid.setUUID()
end

function uuid.setUUID()
	currentUUID = playdate.string.UUID(12)
end

function uuid.denit()
	currentUUID = nil
end

function playdate.AButtonDown()
	uuid.setUUID()
end
