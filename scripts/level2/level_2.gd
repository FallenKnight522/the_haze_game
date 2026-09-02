extends Node
@onready var text_window: CanvasLayer = %Text_window
@onready var hint_: hint = %hint
@onready var player: CharacterBody2D = %Player
@onready var file_manager: Node2D = %FileManager
@onready var fade_out_rect: ColorRect = $Graphics/Colours2/ColorRect


func _ready() -> void:
	get_viewport().canvas_cull_mask &= ~8
	text_window.text_finished.connect(player.start_movement)
	text_window.text_started.connect(player.stop_movement)
	text_window.window_finished.connect(hint_.windowLeft)
	SignalManager.show_text.connect(text_window.queue_text)
	SignalManager.show_choice2.connect(text_window.queue_choice2)
	SignalManager.change_room.connect(newday)
	SignalManager.show_dialog.connect(text_window.queue_dialog)
	SignalManager.move_player.connect(move_player)
	SignalManager.download_file.connect(file_manager.extrah_zip)
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


func newday():
	player.global_position = Vector2(-571, 0)
	
func starting_dialog():
	text_window.queue_text("Alright. IPR Archives. Time to get some answers")
func move_player(pos: Vector2):
	player.global_position = pos

func outro():
	player.global_position = Vector2(-571, 0)
	await fadeout()
	##start scene
	player.reset_movement()
	text_window.clear()
	await fadein()
	player.global_position = Vector2(-571, 0)
	
func fadeout():
	player.stop_movement()
	var tween_out = create_tween()
	tween_out.tween_property(fade_out_rect,"color:a", 1.0, 0.3)
	await tween_out.finished
func fadein():
	var tween_in = create_tween()
	tween_in.tween_property(fade_out_rect, "color:a", 0.0,0.3)
	await tween_in.finished
	player.start_movement()
