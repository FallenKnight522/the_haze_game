extends "res://scripts/object_collision.gd"


func interact():
	SignalManager.show_text.emit("ISIC? It looks like it belongs to Alice.")
	SignalManager.show_text.emit("Hang on, did she ever go to university? I thought... this does not add up...")
	SignalManager.show_text.emit("Anyway, that's not important. I need to find her, and this means she was here. I must be close.")
	SignalManager.download_file.emit("io.zip")
