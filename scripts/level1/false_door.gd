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
@onready var haze_object: the_haze_object = $the_haze_object

static var doorsNum = 0
static var lastOpened = null
static var sameOpene= 0
static var file1 = false
static var file2 = false
var interracted = false

func interact():
	if !interracted:
		interracted = true
		doorsNum-=1
		if(doorsNum <= 0 && !file1):
			file1 = true
			SignalManager.download_file.emit("sw.zip")
	if(lastOpened != self.global_position):
		sameOpene = 0
		lastOpened = self.global_position
	else:
		if(sameOpene == 1 && door_state!= type.Closed):
			SignalManager.show_text.emit("Maybe, I should keep trying the same door...")
	if door_state == type.Closed:
		if behind_player:
			SignalManager.show_text.emit("This door is locked. Did it lock after you entered?")
		else:
			SignalManager.show_text.emit("This door is locked.")
	else:
		if door_state == type.Spiraling:
			animated_sprite_2d.play("open_shift")
		else:
			animated_sprite_2d.play("open")
		SignalManager.show_choice2.emit("This door is unlocked. Enter?","Yes", "No",leave_room, stay)
		haze_object.can_interact = false
func leave_room():
	if lastOpened == self.global_position:
		sameOpene+=1
		if(sameOpene >= 3 && !file1):
			file1 = true
			SignalManager.download_file.emit("sw.zip")
			
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
	elif(door_state == type.Spiraling):
		if(!file2):
			file2 = true
			SignalManager.change_room.emit("hallway","res://scenes/rooms/Hallway.tscn")
			SignalManager.download_file.emit("Ob.zip")
		else:
			SignalManager.change_room.emit("hallway","res://scenes/rooms/Hallway.tscn")
	else:
		reeneter_room.emit()
	haze_object.can_interact = true
func stay():
	animated_sprite_2d.play("close")
	haze_object.can_interact = true
func shift():
	animated_sprite_2d.play("shift")
	interracted = false
	if door_state == type.Spiraling || door_state == type.Fake:
		if randf() < 0.20:
				door_state = type.Spiraling
				await animated_sprite_2d.animation_finished
				animated_sprite_2d.play("shift")
		else:
				door_state = type.Fake
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
