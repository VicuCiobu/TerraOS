function downloadFile(path, url)
	term.clear()
	term.setCursorPos(1, 1)
	term.setTextColor(colors.orange)
	print("Downloaded " .. path)
	data = http.get(url).readAll()
	file = assert(io.open(path, "w"))
	file:write(data)
	file:close()
end

fs.makeDir("/.terraos/scripts")
fs.makeDir("/.terraos/images")

downloadFile("/.terraos/images/desktop.image", "https://raw.githubusercontent.com/Laboratory-Scripts/TerraOS/master/.terraos/images/desktop.image")
downloadFile("/.terraos/scripts/os.lua", "https://raw.githubusercontent.com/Laboratory-Scripts/TerraOS/master/.terraos/scripts/os.lua")

os.reboot()
