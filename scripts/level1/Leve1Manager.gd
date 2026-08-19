extends Node
var exiting = false
@onready var text_window: CanvasLayer = %Text_window

func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("leave")&& !exiting): #Bit legacy code to put leaving into textbox, but since it will be there always, and it can be changed, I will keep it
		exiting = true
		text_window.force_choice2("Do you want to return to the menu?", "Yes", "No", leave, stay)
func leave():
	exiting = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
func stay():
	exiting = false
