extends Node2D
class_name Object_manager

@export var DialogName: String
@onready var dialog: DialogueResource = load("res://dialog/" + DialogName)
var day = 0
signal new_day(day: int)

func interaction(_name: String, _interaction: int, _caller: the_haze_object2 = null):
	pass
func end_conversation():
	pass
