extends "res://scripts/object_collision.gd"


func interact():
	SignalManager.show_text.emit("A cap? It must belong to Dan...")
	SignalManager.show_text.emit("Although... he hasn't worn it for years... it's too small for him.")
	SignalManager.show_text.emit("What is it doing here?")
	SignalManager.download_file.emit("Sc.zip")
