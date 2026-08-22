extends the_haze_object
@onready var shifting_door: shifting_door = $".."


func interact():
	shifting_door.interact()
