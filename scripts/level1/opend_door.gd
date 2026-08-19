extends "res://scripts/object_collision.gd"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func interact():
	animated_sprite_2d.play("open")
	SignalManager.show_choice2.emit("This door is unlocked. Enter?","Yes", "No",leave_room, stay)
func leave_room():
	animated_sprite_2d.play("default")
	pass
func stay():
	animated_sprite_2d.play("close")
