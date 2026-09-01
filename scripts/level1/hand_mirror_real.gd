extends the_haze_object
var file=false
func  interact():
	SignalManager.show_text.emit("It feels like there is a mirror here...")
	SignalManager.show_text.emit("I can touch it, but not see it.")
	if !file:
		SignalManager.download_file.emit("Au.zip")
		file = true
