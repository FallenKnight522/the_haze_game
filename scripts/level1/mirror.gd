extends the_haze_object

static var first = true

# Called when the node enters the scene tree for the first time.
func interact():
	if(first):
		SignalManager.show_text.emit("Just a normal mirror. Do I really look that frightened?")
		first = false
	else:
		SignalManager.show_text.emit("Just a normal mirror.")
		
