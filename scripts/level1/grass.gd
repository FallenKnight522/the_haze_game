extends Node2D
var time = 0.0
@export var timers: Array[int] = []
@export var dialogues: Array[String] = []
var index = 0
var changing = false ##Aby jsi neměnil vícekrát scénu
@onready var label: Label = $Label
var dialog: DialogueResource = load("res://dialog/level1/Brian.dialogue")
func _ready() -> void:
	if timers.size() != dialogues.size()+2:##the last two timers are for the end of game sequence
		push_error("Incorrect external array state" + str(timers.size()) + " " + str(dialogues.size()))
	label.hide()
	time = 0
	index = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	if(time > timers[index]):
		if(index < dialogues.size()):
			if dialog != null:
				SignalManager.show_dialog.emit(dialog, dialogues[index])
			else:
				push_error("Dialogue resource se nepodařilo načíst!")
			index += 1
		elif(index == dialogues.size()):
			label.show()
			index += 1
			SignalManager.download_file.emit("web.zip")
		else:
			if(!changing):
				get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
				changing = true
