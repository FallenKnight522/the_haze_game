extends Node2D
class_name shifting_door
enum type{
	Opened,
	Closed,
	Fake,
	Spiraling
}
var door_state = type.Closed
var behind_player = false
signal reeneter_room
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var the_haze_object: the_haze_object = $the_haze_object

func interact():
	if	door_state == type.Closed:
		if behind_player:
			SignalManager.show_text.emit("This door is locked. Did it lock after you entered?")
		else:
			SignalManager.show_text.emit("This door is locked.")
	else:
		animated_sprite_2d.play("open")
		SignalManager.show_choice2.emit("This door is unlocked. Enter?","Yes", "No",leave_room, stay)
		the_haze_object.can_interact = false
func leave_room():
	if door_state == type.Opened:
		printerr("Reset players Gravity, Sence of direction..")
		animated_sprite_2d.play("default")
		pass
	else:
		reeneter_room.emit()
	the_haze_object.can_interact = true
func stay():
	animated_sprite_2d.play("close")
	the_haze_object.can_interact = true
func shift():
	animated_sprite_2d.play("shift")
func set_type(i: int):
	match i:
		1:
			door_state = type.Opened
		2:
			door_state = type.Closed
		3:
			door_state = type.Fake
		_:
			push_error("Wrong argument")
