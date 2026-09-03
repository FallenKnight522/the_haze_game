extends Control
var time = Time.get_date_string_from_system()
var time_when = [ "2026-08-16",  "2026-01-01", "2026-11-01", "2026-12-01"]
var text_full = [ "Paranoia",  "Acknowlegment", "Isolation", "Nudging"]
var text_title = [  "I. House that was not there",  "II. to Know", "III. Through the Fog", "IV. ???"]
var time_letter = [  "P",  "A", "I", "N"]

@onready var tutorial: Button = $VBoxContainer/Tutorial
@onready var levels: Array[Button] = [$"VBoxContainer/Level 1", $"VBoxContainer/Level 2", $"VBoxContainer/Level 3", $"VBoxContainer/Level 4"]
@onready var exit: Button = $VBoxContainer/Exit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tutorial.text = "Tutorial"
	for i in range(4):
		button_time(levels[i], time_when[i], SignalManager.text_full_on[i], text_full[i], text_title[i],time_letter[i])
	exit.text = "Exit"

func button_time(button, timeTo,fulltext, text1, text2, text3):
	if(time>=timeTo && fulltext):
		button.text = text1
	elif(time>=timeTo):
		button.text = text2
	else:
		button.text = text3
		button.disabled = true

			
func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn") # Replace with function body.


func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level1.tscn")


func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level2.tscn")


func _on_level_3_pressed() -> void:
	pass # Replace with function body.


func _on_level_4_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
