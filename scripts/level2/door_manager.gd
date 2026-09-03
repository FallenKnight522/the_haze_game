extends Node2D
@export var doors: Array[Area2D] = []
signal hour_changed
var spiral_door = null
var spiral_progress = 0
var time = 0.0
@onready var hrníček: the_haze_object = $hrníček
@onready var soška: the_haze_object = $soška

func _ready() -> void:
	reset_doors()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time -= delta
	if( time <= 0):
		next_phase()

func reset_doors():
	for door in doors:
		door.reset()
	if doors.size() == 0:
		push_error("Empty doors list")
		return
	spiral_door = doors[randi_range(0, doors.size()-1)]
	spiral_progress = 0
	hrníček.hide()
	soška.hide()
	soška.interraction_allowed = false
	hrníček.interraction_allowed = false
	time = randi_range(20,80)
func next_phase():
	match spiral_progress:
		0:
			soška.poslist.append(spiral_door.statue_pos)
			soška.poslist.append(spiral_door.statue_pos_2)
			soška.move_self()
			soška.interraction_allowed = true
			soška.show()
		1:
			hrníček.global_position = spiral_door.cap_pos.global_position
			hrníček.interraction_allowed = true
			hrníček.show()
		2:
			spiral_door.spiraldoor = true
		3:
			spiral_door.spiraldoor = false
		4:
			soška.hide()
			soška.interraction_allowed = false
			soška.poslist.clear()
		5:
			hrníček.hide()
			hrníček.interraction_allowed = false
			spiral_progress = -1
		_:
			push_error("Invalid state")
	spiral_progress+=1
	time = randi_range(5,20)
