extends the_haze_object
@onready var door_room: Node2D = $".."
enum type{
	Opened,
	Closed,
	Fake,
	Spiraling
}
var door_state = type.Closed
var behind_player = true



func interact():
	if	door_state == type.Closed:
		if behind_player:
			SignalManager.show_text.emit("This door is locked. Did it lock after you entered?")
		else:
			SignalManager.show_text.emit("This door is locked.")
	else:
		animated_sprite_2d.play("open")
		SignalManager.show_choice2.emit("This door is unlocked. Enter?","Yes", "No",leave_room, stay)
func leave_room():
	printerr("Reset players Gravity, Sence of direction..")
	animated_sprite_2d.play("default")
	pass
func stay():
	animated_sprite_2d.play("close")
func leave_room():
	door_room.enter()
