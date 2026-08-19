extends "res://scripts/object_collision.gd"


func interact():
	SignalManager.show_text.emit("This door is locked. Did it lock after you entered?")
