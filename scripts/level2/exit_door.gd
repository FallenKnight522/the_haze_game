extends the_haze_object
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var Manager: Object_manager

func _ready() -> void:
	hide_hint()
	animated_sprite_2d.play("default")
func interact():
		animated_sprite_2d.play("open")
		await animated_sprite_2d.animation_finished
		SignalManager.show_choice2.emit("Leave for the day?", "Yes", "No",  leave, stay)
func stay():
	animated_sprite_2d.play("close")
func leave():
	animated_sprite_2d.play("default")
	Manager.end_day()
	
