extends Node2D
@onready var opened_door: opened_door = $opened_door
@onready var margaret: the_haze_object = $the_haze_object
@onready var room: TileMapLayer = $Room
@onready var room_2: TileMapLayer = $Room2
@onready var pos_1: Marker2D = $Pos1
@onready var pos_2: Marker2D = $Pos2
var rotated = true ##so firt put it in nonrotated position
var rotations = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#door_section()
	SignalManager.show_text.emit("Wow, that is a huge staircase")
	SignalManager.show_text.emit("I can't see the botom or top")
	SignalManager.show_text.emit("Better tread carefully, it looks slippery")
	Margaret_section()
func Margaret_section():
	rotation()
	opened_door.hide()
	margaret.show()
	opened_door.interraction_allowed = false
	margaret.interraction_allowed = true
func door_section():
	rotation()
	opened_door.show()
	margaret.hide()
	opened_door.interraction_allowed = true
	margaret.interraction_allowed = false
func empty_section():
	rotation()
	opened_door.hide()
	margaret.hide()
	opened_door.interraction_allowed = false
	margaret.interraction_allowed = false
func rotation():
	rotations+=1
	match rotations:
		5:
			SignalManager.show_text.emit("[Heavy breathing]... so... many stairs...")
		10:
			SignalManager.show_text.emit("It feels like this staircase spins and twists forever")
		50:
			SignalManager.show_text.emit("No.. more... stairs... make ... it ...STOP... Where is up? Where is down? I need to leave")
		100:
			SignalManager.show_text.emit("[Soft sobbing] I need a door out... these stairs twist forever")
	SignalManager.fear.emit(rotations%2)
	if(rotated):
		rotated = false
		room.show()
		room.collision_enabled = true
		room_2.hide()
		room_2.collision_enabled = false
		margaret.global_position = pos_1.global_position
		opened_door.global_position = pos_1.global_position
	else:
		rotated = true
		room.hide()
		room.collision_enabled = false
		room_2.show()
		room_2.collision_enabled = true	
		margaret.global_position = pos_2.global_position
		opened_door.global_position = pos_2.global_position
	
