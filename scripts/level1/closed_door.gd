extends the_haze_object
var behind_player = true

func interact():
	if behind_player:
		SignalManager.show_text.emit("This door is locked. Did it lock after you entered?")
	else:
		SignalManager.show_text.emit("This door is locked.")
