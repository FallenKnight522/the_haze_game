extends the_haze_object
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"

var first = false

var inter = 1

func interact():
	match inter:
		1:
			SignalManager.show_text.emit("A table with some drawers.")
			SignalManager.show_choice2.emit("I wander what is inside.", "Look", "Don't", Open)
		2:
			SignalManager.show_text.emit("Did the drawer cut it of? Does it belong to someone trapped here?..")
			inter +=1
		3:
			SignalManager.fear.emit(5)
			inter +=1
			SignalManager.show_text.emit("I really should leave it be...")
		4:
			inter +=1
			SignalManager.show_text.emit("Ok, one more peak... ")
			animated_sprite_2d.play("close")
			animated_sprite_2d.play("look_inside")
			SignalManager.show_text.emit("Yep, still there... and still too long to be human. Am I going crazy?..")
			SignalManager.fear.emit(10)
		_:
			SignalManager.show_text.emit("Not touching that again")
	
func Open():
	inter +=1
	animated_sprite_2d.play("look_inside")
	SignalManager.show_text.emit("A finger... WHAT? That cannot be human.. It is too long...")
	SignalManager.show_text.emit("(I need to leave... as soon as find Margaret... Alice... and Dan...)")
	animated_sprite_2d.play("close")

			
