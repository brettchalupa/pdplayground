apps = {}

import "apps/accel"
import "apps/debug"
import "apps/display"
import "apps/input"
import "apps/keyboard"
import "apps/main_menu"
import "apps/meta"
import "apps/serial"
import "apps/sysinfo"
import "apps/time"
import "apps/uuid"

function apps.init()
	apps.switchTo(apps.mainMenu)
end

function apps.switchTo(app)
	if type(app) == "string" then
		app = apps[app]
	end

	assert(app, "invalid app: " .. tostring(app))

	if apps.current and apps.current.denit then
		apps.current.denit()
	end

	apps.current = app

	if apps.current.init then
		apps.current.init()
	end
end
