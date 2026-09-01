extends "res://scripts/object_collision.gd"


func interact():
	SignalManager.show_text.emit("Is this Margaret's phone? Did she lose it here?")
	SignalManager.show_text.emit("It looks shattered...")
	SignalManager.download_file.emit("dio.zip")
	
