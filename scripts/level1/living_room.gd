extends Node2D

@onready var open_door: the_haze_object = $open_door
@onready var closed_door: the_haze_object = $closed_door

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	open_door.position = Vector2(-646,-278)
	closed_door.position = Vector2(-643,12)
