extends Node
@onready var text_window: CanvasLayer = %Text_window
@onready var character_body: CharacterBody2D = $"../Player"
# Made by Spider.llm
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text_window.text_finished.connect(character_body.start_movement)
	text_window.text_started.connect(character_body.stop_movement)
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("leave")): #Bit legacy code to put leaving into textbox, but since it will be there always, and it can be changed, I will keep it
		
		text_window.force_choice2("Do you want to return to the menu?", "Yes", "No", leave, stay)
		text_window.force_enabled = false
func leave():
	text_window.force_enabled = true
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
func stay():
	text_window.force_enabled = true
