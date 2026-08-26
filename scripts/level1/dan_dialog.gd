extends the_haze_object
var dialog: DialogueResource = load("res://dialog/level1/Dan.dialogue")
@onready var closed_door: the_haze_object = $"../../door/closed_door"
var dialog_part = 0
var doors = 0
func door_opened():
	doors-=1;
func interact():
	if dialog != null:
		match dialog_part:
			0:
				SignalManager.show_dialog.emit(dialog)
				doors = 5
			1:
				SignalManager.show_dialog.emit(dialog, "start2")
				doors = 3
			2:
				SignalManager.show_dialog.emit(dialog, "start3")
				doors = 5
			3:
				SignalManager.show_dialog.emit(dialog, "start4")
			_:
				SignalManager.show_dialog.emit(dialog, "cycle")
				dialog_part=3
		dialog_part+=1
	else:
		push_error("Dialogue resource se nepodařilo načíst!")
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") && interraction_allowed&&doors <= 0:
		can_interact = true
		show_hint()
