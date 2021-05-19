function downloadFile(path, url)
	print("Downloading: " .. path)
	data = http.get(url).readAll()
	file = assert(io.open(path, "w"))
	file:write(data)
	file:close()
end

fs.makeDir("/.terraos/scripts")
fs.makeDir("/.terraos/images")

--downloadFile("/void/void", "https://raw.github.com/Vilsol/VoidOS/master/void/void")

os.reboot()
