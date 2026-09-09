extends Node2D
@export var doors: Array[Area2D] = []
@export var locked_doors: Array[Area2D] = []
var spiral_door = null
var spiral_progress = 0
var time = 0.0
@onready var hrnicek: the_haze_object = $hrníček
@onready var soska: the_haze_object = $soška
@onready var interaction_manager: Object_manager = $"../InteractionManager"


func _ready() -> void:
	reset_doors()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time -= delta
	if( time <= 0 && spiral_door != null):
		next_phase()

func reset_doors():
	for door in doors:
		door.reset()
	if interaction_manager.day != 4:
		for door in locked_doors:
			door.closed = true
	if doors.size() == 0:
		push_error("Empty doors list")
		return
	spiral_door = doors[randi_range(0, doors.size()-1)]
	spiral_progress = 0
	hrnicek.hide()
	soska.hide()
	soska.interraction_allowed = false
	hrnicek.interraction_allowed = false
	time = randi_range(20,80)
func next_phase():
	match spiral_progress:
		0:
			soska.poslist.append(spiral_door.statue_pos)
			soska.poslist.append(spiral_door.statue_pos_2)
			soska.move_self()
			soska.interraction_allowed = true
			soska.show()
		1:
			hrnicek.global_position = spiral_door.cap_pos.global_position
			hrnicek.interraction_allowed = true
			hrnicek.show()
		2:
			spiral_door.spiraldoor = true
		3:
			spiral_door.spiraldoor = false
		4:
			soska.hide()
			soska.interraction_allowed = false
			soska.poslist.clear()
		5:
			hrnicek.hide()
			hrnicek.interraction_allowed = false
			spiral_progress = -1
		_:
			push_error("Invalid state")
	spiral_progress+=1
	time = randi_range(5,20)
