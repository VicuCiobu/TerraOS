function downloadFile(path, url)
	term.clear()
	term.setCursorPos(1, 1)
	term.setTextColor(colors.orange)
	print("Installing ... ")
	term.setCursorPos(1, 3)
	term.setTextColor(colors.white)
	print(path)
	data = http.get(url).readAll()
	file = assert(io.open(path, "w"))
	file:write(data)
	file:close()
end

fs.makeDir("/.terraos/images")

downloadFile("/.terraos/images/desktop.image", "https://raw.github.com/Laboratory-Scripts/TerraOS/master/.terraos/images/desktop.image")
downloadFile("/.terraos/scripts/os.lua", "https://raw.github.com/Laboratory-Scripts/TerraOS/master/.terraos/scripts/os.lua")
downloadFile("/.terraos/version.ver", "https://raw.github.com/Laboratory-Scripts/TerraOS/master/.terraos/version.ver")
downloadFile("/startup.lua", "https://raw.github.com/Laboratory-Scripts/TerraOS/master/startup.lua")

os.reboot()
