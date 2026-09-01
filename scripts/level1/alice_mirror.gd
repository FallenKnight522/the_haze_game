extends the_haze_object
var interacted = false
var file = false
var dialog: DialogueResource = load("res://dialog/level1/Alice.dialogue")
@onready var zrcadlo_alice: TextureRect = $".."

# Called when the node enters the scene tree for the first time.
func interact():
	if !interacted:
		interacted = true
		if dialog != null:
			SignalManager.show_dialog.emit(dialog)
		else:
			push_error("Dialogue resource se nepodařilo načíst!")
	elif(!file):
		SignalManager.download_file.emit("d_.zip")
		file = true
	else:
		SignalManager.show_text.emit("(I need to find a way to reach her. This glass or mirror or whatever it is.. I cannot go through it)")
func twist(fear):
	zrcadlo_alice.material.set_shader_parameter("fear_intensity", (fear/10)*(fear/10)*0.01)
