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
		var rand = randi_range(0,100)
		if rand < 15:
			SignalManager.change_room.emit("door_room", "res://scenes/rooms/Door_Room.tscn")
		elif rand < 30:
			SignalManager.change_room.emit("nausea_room", "res://scenes/rooms/NauseaRoom.tscn")
		elif rand < 45:
			SignalManager.change_room.emit("gravity_room", "res://scenes/rooms/GravityRoom.tscn")
		elif rand < 60:
			SignalManager.change_room.emit("living_room", "res://scenes/rooms/Living_room.tscn")
		elif rand < 75:
			SignalManager.change_room.emit("j_room","res://scenes/rooms/J_room.tscn")
		elif rand < 90:
			SignalManager.change_room.emit("maze_room","res://scenes/rooms/MazeRoom.tscn")
		elif rand < 92:
			SignalManager.change_room.emit("hallway","res://scenes/rooms/Hallway.tscn")
		elif rand < 96:
			SignalManager.change_room.emit("mirror_room","res://scenes/rooms/Mirror_room.tscn")
		else:
			SignalManager.change_room.emit("spiral_stairs","res://scenes/rooms/Spiral_Staircase.tscn")	
		animated_sprite_2d.play("default")
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
