extends Node2D
class_name Object_manager

@export var DialogName: String
@onready var dialog: DialogueResource = load("res://dialog/" + DialogName)
@onready var fear: CanvasLayer = %Fear


func interaction(_name: String, _interaction: int, caller: Node):
	if dialog != null:
			match _name:
				"test":
					SignalManager.fear.emit(10)
				_:
					SignalManager.show_dialog.emit(dialog, _name + str(_interaction), self)
	else:
			push_error("Dialog not loaded")
func end_conversation():
	pass
