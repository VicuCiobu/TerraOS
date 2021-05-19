term.clear()
term.setCursorPos(1, 1)
term.setTextColor(colors.orange)
print("Loading ...")

sleep(1.9)

-- Variables
running = true

-- Images
_dt = paintutils.loadImage("/.terraos/images/desktop.image")

-- Booleans
_ms = 0
_rcm = 0

-- Functions
clear = function()
    term.setBackgroundColor(colors.black)
    term.clear()
    term.setCursorPos(1, 1)
end

writeVersion = function()
    versionFile = fs.open("/.terraos/version.ver", "r")
    write("TerraOS" + versionFile)
    versionFile.close()
end

drawTaskbar = function()
    term.setCursorPos(1, 1)
    term.setBackgroundColor(colors.blue)
    term.clearLine()
    term.setCursorPos(1, 1)
    term.setBackgroundColor(colors.lime)
    term.setTextColor(colors.white)
    term.write("Menu")
    term.setCursorPos(1, 19)
    term.setBackgroundColor(colors.blue)
    term.clearLine()
    term.setCursorPos(1, 19)
    term.setBackgroundColor(colors.lime)
    term.setTextColor(colors.white)
    term.write("Configure Wallpaper")
    term.setCursorPos(6, 1)
    term.setBackgroundColor(colors.blue)
    term.setTextColor(colors.white)
    writeVersion()
end

drawMenu1 = function()
    term.setCursorPos(2, 2)
    term.setBackgroundColor(colors.white)
    term.setTextColor(colors.lime)
    print(" Start CraftOS     ")
    term.setCursorPos(2, 3)
    term.setBackgroundColor(colors.white)
    term.setTextColor(colors.lime)
    print(" Lua               ")
    term.setCursorPos(2, 4)
    term.setBackgroundColor(colors.white)
    term.setTextColor(colors.lime)
    print("                   ")
    term.setCursorPos(2, 5)
    term.setBackgroundColor(colors.white)
    term.setTextColor(colors.red)
    print(" Restart           ")
    term.setCursorPos(2, 6)
    term.setBackgroundColor(colors.white)
    term.setTextColor(colors.red)
    print(" Shutdown          ")
    term.setCursorPos(2, 7)
    term.setBackgroundColor(colors.white)
    term.setTextColor(colors.lime)
    print("                   ")
    term.setCursorPos(2, 8)
    term.setBackgroundColor(colors.white)
    term.setTextColor(colors.red)
    print(" Reset Driver      ")
end

drawDesktop = function()
    term.setBackgroundColor(colors.black)
    term.clear()
    term.setCursorPos(1, 1)
    paintutils.drawImage(_dt, 1, 1)
end

stop = function()
    clear()
    running = false
    term.setTextColor(colors.orange)
    print("Shutting down ...")
    sleep(1.1)
    os.shutdown()
end

runTime = function()
    while running do
        local event, button, x, y = os.pullEvent("mouse_click")
        if event == "mouse_click" then
            if _ms == 0 and button == 1 and x < 20 and y == 1 then
                drawMenu1()
                _ms = 1
            elseif _ms == 1 and button == 1 and y == 6 and x < 20 then
                stop()
            elseif _ms == 1 and button == 1 and y == 3 and x < 20 then
                clear()
                running = false
                term.setCursorPos(1, 1)
                term.setBackgroundColor(colors.black)
                term.setTextColor(colors.orange)
                print("TerraOS has been shutdown\n\nIf you want to go back to TerraOS,\nfirstly type the command 'exit()',\nthen type 'reboot'.\n")
                shell.run("lua")
            elseif _ms == 1 and button == 1 and y == 2 and x < 20 then
                clear()
                running = false
                term.setCursorPos(1, 1)
                term.setBackgroundColor(colors.black)
                term.setTextColor(colors.orange)
                print("TerraOS has been shutdown\n\nIf you want to go back to TerraOS,\ntype the command 'reboot'.\n\n")
                shell.run("/rom/programs/shell.lua")
            elseif _ms == 1 and button == 1 and y == 5 and x < 20 then
                clear()
                running = false
                term.setCursorPos(1, 1)
                term.setBackgroundColor(colors.black)
                term.setTextColor(colors.orange)
                print("Restarting ...")
                sleep(0.8)
                os.reboot()
            elseif _ms == 1 and button == 1 and y == 8 and x < 20 then
                clear()
                sleep(0.1)
                init()
            elseif _ms == 1 and button == 1 and y == 1 and x < 20 then
                init()
            elseif button == 1 and y == 19 and x < 19 then
                shell.run("paint", "/.terraos/images/desktop.image")
	            _dt = paintutils.loadImage("/.terraos/images/desktop.image")
            end
        end
    end
end

checkUpdate = function()
	versionFile = fs.open("/.terraos/version.ver", "r")
	currentVersion = tonumber(versionFile.readLine())
	newVersion = tonumber(http.get("https://raw.github.com/Laboratory-Scripts/TerraOS/master/.terraos/version.ver").readAll())
	versionFile.close()

	if (newVersion > currentVersion) then
		return true
    else
       	return false
	end
end

run = function()
    term.clear()
    term.setCursorPos(1, 1)
    term.setTextColor(colors.orange)
    print("Checking for updates ...")

    sleep(0.6)

    if (checkUpdate()) then
        term.clear()
        term.setCursorPos(1, 1)
        term.setTextColor(colors.orange)
        write("An update has been detected! Do you want to install them?")
        term.setCursorPos(1, 2)
        term.setTextColor(colors.white)
        write("(Yes/No)")
        term.setCursorPos(1, 4)
        term.setTextColor(colors.white)
        write("> ")
        update = read()
    end

    if (update == "Yes" or update == "yes" or update == "y" or update == "Y") then
        shell.run("/.terraos/scripts/installer.lua")
    else
        init()
    end
end

init = function()
    clear()
    _ms = 0
    drawDesktop()
    drawTaskbar()
    runTime()
end

-- Main
init()
