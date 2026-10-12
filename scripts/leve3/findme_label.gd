extends Label
var blick = false
var timer =  0.0
var time_max = 0.5
var message = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if time_max  < timer:
		timer = 0
		if blick:
			if message:
				var rf = randf()
				if rf < 0.1:
					text = " Search "
				elif rf < 0.2:
					text = " the_haze_game "
				elif rf < 0.3:
					text = " on Github "
				else:
					text = "FIND ME"					
			if visible:
				hide()
			else:
				show()
