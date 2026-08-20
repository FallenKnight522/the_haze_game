extends "res://scripts/object_collision.gd"


func interact():
	SignalManager.show_text.emit("A cap? It must belong to Dan...")
	SignalManager.show_text.emit("Althought.. he did not wear it for years.. its too small for him")
	SignalManager.show_text.emit("What is it doing here")
