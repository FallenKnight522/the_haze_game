extends "res://scripts/object_collision.gd"


func interact():
	SignalManager.show_text.emit("Is this Margaret's phone? Did she loose it here?")
	SignalManager.show_text.emit("It look shattered...")
	
