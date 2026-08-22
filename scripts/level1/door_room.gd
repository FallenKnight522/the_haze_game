extends Node2D
@export var door_pos: Array[Vector2] = []
var doors = []
const dvere = preload("uid://c6i4kyrrgeain")
const timer = 60
var time = 0
var confused = 0
const startpos = Vector2(-618,-44)
var locked = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	door_pos.shuffle()
	for i in range(door_pos.size()):
		var door = dvere.instantiate() as shifting_door
		if(door!=null):
			doors.append(door)
			if door_pos[i] ==startpos: ##starting position
					doors[i].set_type(2)
					doors[i].behind_player = true
					locked = i
			elif i <= 2:
					doors[i].set_type(1)
			elif i <= 5:
					doors[i].set_type(2)
			else:
				doors[i].set_type(3)
				doors[i].reeneter_room.connect(shuffle_room)
			doors[i].global_position = door_pos[i]
			add_child(doors[i])
		else:
			push_error("Cast unsuccesfull")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	if(time>timer):
		time = 0
		shuffle_room(false)
func shuffle_room(player = true):
	confused+=1
	SignalManager.fear.emit(confused/2)
	door_pos.shuffle()
	for i in range(door_pos.size()):
		doors[i].global_position = door_pos[i]
		doors[i].shift()
		if(player&&i == locked):
			SignalManager.move_player.emit(door_pos[i])
	
