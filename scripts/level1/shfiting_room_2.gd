extends the_haze_object
@onready var shifting: shifting_door = $".."


func interact():
	shifting.interact()
