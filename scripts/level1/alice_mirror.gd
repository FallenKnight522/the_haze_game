extends the_haze_object
var interacted = false
var dialog: DialogueResource = load("res://dialog/Alice.dialogue")

# Called when the node enters the scene tree for the first time.
func interact():
	if !interacted:
		interacted = true
		if dialog != null:
			SignalManager.show_dialog.emit(dialog)
		else:
			push_error("Dialogue resource se nepodařilo načíst!")
	else:
		SignalManager.show_text.emit("(I need to find how to reach her. This glass or mirror or whatever it is.. I cannot go through it)")
