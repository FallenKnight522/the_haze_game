extends the_haze_object	
var dialog: DialogueResource = load("res://dialog/level1/Margaret.dialogue")
var dialog_part = 0

# Called when the node enters the scene tree for the first time.
func interact():
	if dialog != null:
		match dialog_part:
			0:
				SignalManager.show_dialog.emit(dialog)
			1:
				SignalManager.show_dialog.emit(dialog, "start2")
			2:
				SignalManager.show_dialog.emit(dialog, "cycle1")
			3:
				SignalManager.show_dialog.emit(dialog, "cycle2")
			4:
				SignalManager.show_dialog.emit(dialog, "cycle3")
				dialog_part=1
				SignalManager.download_file.emit("se.zip")
		
		dialog_part+=1
	else:
		push_error("Dialogue resource se nepodařilo načíst!")
