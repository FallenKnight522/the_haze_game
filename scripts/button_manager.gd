extends Control
var time = Time.get_date_string_from_system()
var time1 = "2026-08-16"
var time2 = "2026-08-18"
var time3 = "2026-08-18"
var time4 = "2026-12-18"

@onready var tutorial: Button = $VBoxContainer/Tutorial
@onready var level_1: Button = $"VBoxContainer/Level 1"
@onready var level_2: Button = $"VBoxContainer/Level 2"
@onready var level_3: Button = $"VBoxContainer/Level 3"
@onready var level_4: Button = $"VBoxContainer/Level 4"
@onready var exit: Button = $VBoxContainer/Exit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tutorial.text = "Tutorial"
	button_time(level_1, time1, "Paranoia", "I. House that was not there")	
	button_time(level_2, time2, "Acknowlegment", "II. to Know")	
	button_time(level_3, time3, "Isolation", "III. Through the Fog")	
	button_time(level_4, time4, "Nudging", "IV. ???")	
	exit.text = "Exit"

func button_time(button, timeTo, text1, text2):
	if(time>=timeTo):
		button.text = text1
	else:
		button.text = text2
		button.disabled = true


func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn") # Replace with function body.


func _on_level_1_pressed() -> void:
	pass # Replace with function body.


func _on_level_2_pressed() -> void:
	pass # Replace with function body.


func _on_level_3_pressed() -> void:
	pass # Replace with function body.


func _on_level_4_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
