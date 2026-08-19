extends the_haze_object
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"

var first = false

func interact():
	if !first:
		SignalManager.show_text.emit("Quite a big wardrobe. Looks heavy.")
		SignalManager.show_choice2.emit("Look inside?", "Yes", "No", Open)
		first = true
	else:
		SignalManager.show_text.emit("What is that screeching sound?")
		SignalManager.fear.emit(5)

func Open():
	animated_sprite_2d.play("look_inside")
	SignalManager.show_text.emit("It seems empty")
	animated_sprite_2d.play("close")

			
