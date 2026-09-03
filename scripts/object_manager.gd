extends Node2D
class_name Object_manager

@export var DialogName: String
@onready var dialog: DialogueResource = load("res://dialog/" + DialogName)


func interaction(_name: String, _interaction: int, _caller: Node):
	pass
func end_conversation():
	pass
