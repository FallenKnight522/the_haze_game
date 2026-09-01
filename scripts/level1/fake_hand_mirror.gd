extends the_haze_object


# Called when the node enters the scene tree for the first time.
func interact():
	SignalManager.show_text.emit("A mirror on the stairs...")
	SignalManager.show_text.emit("Wait, it's... it's not here.")
	SignalManager.show_text.emit("I can see it, but not touch it...")
	SignalManager.show_text.emit("And it does not have a reflection either...")
