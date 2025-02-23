import "CoreLibs/keyboard"

local gfx <const> = playdate.graphics
local keyboard <const> = playdate.keyboard

apps.keyboard = {
	name = "Keyboard",
	key = "keyboard",
	description = "Information about the game and SDK",
}

local text = nil

function apps.keyboard.init()
	keyboard.show()
	text = ""
end

function apps.keyboard.denit()
	keyboard.hide()
	text = nil
end

function apps.keyboard.update()
	if not keyboard.isVisible() then
		if playdate.buttonJustPressed(playdate.kButtonB) then
			sfx.play(sfx.back)
			apps.switchTo(apps.mainMenu)
			return
		end

		if playdate.buttonJustPressed(playdate.kButtonA) then
			keyboard.show()
		end
	end

	gfx.clear()
	gfx.setFont(fonts.medium)
	gfx.drawText("Keyboard", 12, 12)
	gfx.setFont(fonts.small)

	gfx.drawText("Entered text:", 12, 48)
	gfx.drawText(text, 12, 82)

	if not keyboard.isVisible() then
		gfx.drawText("Press (A) to show keyboard", 12, 140)
	end
end

function playdate.keyboard.textChangedCallback()
	text = keyboard.text
end

