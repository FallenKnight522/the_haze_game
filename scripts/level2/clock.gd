extends Label
@onready var clock: the_haze_object2 = $".."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = clock.Manager.get_time()
