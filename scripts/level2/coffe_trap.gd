extends the_haze_object
@onready var light_switch: the_haze_object = $".."

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") && interraction_allowed && light_switch.Manager.flags.has("coffe"):
		can_interact = true
		show_hint()
func interact():
	if light_switch.light == true && light_switch.jan.interaction > 0:
		SignalManager.show_text.emit("Brian: (Maybe, if I leave the coffe here, I could lure Jan here)")
		SignalManager.show_choice2.emit("Place the coffe?", "Yes", "No", trap)
	elif light_switch.light == false:
		SignalManager.show_text.emit("I can't see anything in this darkness")
	else:
		SignalManager.show_text.emit("An old, out of use office")
func trap():
	light_switch.Manager.flags.erase("coffe")
	light_switch.trap()
