extends Node2D
@onready var opened_door: the_haze_object = $opened_door
@onready var closed_door: the_haze_object = $closed_door


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if randf() < 0.5:
		opened_door.position = Vector2(-525,-329)
		closed_door.position = Vector2(-619,-43)
	else:
		closed_door.position = Vector2(-525,-329)
		opened_door.position = Vector2(-619,-43)
		closed_door.behind_player = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
