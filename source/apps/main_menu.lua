local gfx <const> = playdate.graphics

apps.mainMenu = {
	name = "Main Menu",
}

local selectedAppIndex = 1
local mainMenu <const> = apps.mainMenu
local menuApps = {}
local listview = playdate.ui.gridview.new(0, 24)

local function initListview()
	listview.backgroundImage = playdate.graphics.nineSlice.new("sprites/shadowbox", 4, 4, 45, 45)
	listview:setNumberOfRows(#menuApps)
	listview:setCellPadding(0, 0, 8, 6)
	listview:setContentInset(24, 24, 0, 10)
end

function apps.mainMenu.init()
	if #menuApps == 0 then
		for k, v in pairs(apps) do
			if k ~= "current" and k ~= "mainMenu" and not util.isFunction(v) then
				table.insert(menuApps, v)
			end
		end
	end

	table.sort(menuApps, function(a, b)
		return a.name < b.name
	end)

	initListview()
end

function apps.mainMenu.update()
	if playdate.buttonJustPressed(playdate.kButtonA) then
		sfx.play(sfx.select)
		apps.switchTo(menuApps[selectedAppIndex])
		return
	end

	if playdate.buttonJustPressed(playdate.kButtonUp) then
		sfx.play(sfx.up)

		listview:selectPreviousRow(true)
	end

	if playdate.buttonJustPressed(playdate.kButtonDown) then
		sfx.play(sfx.down)

		listview:selectNextRow(true)
	end

	selectedAppIndex = listview:getSelectedRow()

	gfx.clear()
	gfx.setFont(fonts.medium)
	gfx.drawText("Playdate Playground", 12, 12)

	gfx.setFont(fonts.small)
	gfx.drawText(meta.versionAndBuild, 12, screen.height - 28);
	gfx.drawText("by " .. meta.author, screen.width - 164, screen.height - 28);

	 --gfx.drawRect(40, 48, 340, 140)
	listview:drawInRect(80, 48, 240, 156)
end

function listview:drawCell(section, row, column, selected, x, y, width, height)
	if selected then
		gfx.fillRoundRect(x, y, width, 30, 4)
		gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
	else
		gfx.setImageDrawMode(gfx.kDrawModeCopy)
	end
	gfx.drawTextInRect("" .. menuApps[row].name, x, y + 6, width, height, 1, "...", kTextAlignment.center, fonts.small)
end
