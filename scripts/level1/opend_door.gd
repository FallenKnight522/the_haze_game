extends the_haze_object
class_name opened_door
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func interact():
	animated_sprite_2d.play("open")
	SignalManager.show_choice2.emit("This door is unlocked. Enter?", "Yes", "No", leave_room, stay)
func leave_room():
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
func stay():
	animated_sprite_2d.play("close")
