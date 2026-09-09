extends Node
@onready var text_window: CanvasLayer = %Text_window
@onready var player: CharacterBody2D = %Player
@onready var fade_out_rect: ColorRect = $Colours2/ColorRect
@onready var label: Label = $Colours2/MarginContainer/Label
const starting_pos = Vector2(-571, 0)

func _ready() -> void:
	get_viewport().canvas_cull_mask &= ~8
	text_window.text_finished.connect(player.start_movement)
	text_window.text_started.connect(player.stop_movement)
	SignalManager.show_text.connect(text_window.queue_text)
	SignalManager.show_choice2.connect(text_window.queue_choice2)
	SignalManager.show_dialog.connect(text_window.queue_dialog)
	SignalManager.move_player.connect(move_player)
	text_window.force_enabled = true
	starting_dialog()
					
	
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("leave") && text_window.force_enabled): #Bit legacy code to put leaving into textbox, but since it will be there always, and it can be changed, I will keep it
		
		text_window.force_choice2("Do you want to return to the menu?", "Yes", "No", leave, stay)
		text_window.force_enabled = false
func leave():
	await get_tree().process_frame
	text_window.force_enabled = true
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
func stay():
	await get_tree().process_frame
	text_window.force_enabled = true

	
func starting_dialog():
	text_window.queue_text("Oh no...")
	text_window.queue_text("The house claimed me back")
	text_window.queue_text("God have mercy on my soul") 
	await get_tree().create_timer(5).timeout
	label.text = "You lost \nTry again"
	await get_tree().create_timer(10).timeout
	await fadeout()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
	
func move_player(pos: Vector2):
	player.global_position = pos
	
func fadeout():
	player.stop_movement()
	var tween_out = create_tween()
	tween_out.tween_property(fade_out_rect,"color:a", 1.0, 5)
	await tween_out.finished
