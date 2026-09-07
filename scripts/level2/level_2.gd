extends Node
@onready var text_window: CanvasLayer = %Text_window
@onready var hint_: hint = %hint
@onready var player: CharacterBody2D = %Player
@onready var fade_out_rect: ColorRect = $Graphics/Colours2/ColorRect
const starting_pos = Vector2(1878, -2)
@onready var label: Label = $Graphics/Colours2/MarginContainer/Label
const WeekDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
@onready var door_manager: Node2D = $DoorManager

func _ready() -> void:
	get_viewport().canvas_cull_mask &= ~8
	text_window.text_finished.connect(player.start_movement)
	text_window.text_started.connect(player.stop_movement)
	text_window.window_finished.connect(hint_.windowLeft)
	SignalManager.show_input.connect(text_window.queue_input)
	SignalManager.show_text.connect(text_window.queue_text)
	SignalManager.show_choice2.connect(text_window.queue_choice2)
	SignalManager.change_room.connect(outro)
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


func new_day(day):
	label.visible_ratio =0.0
	door_manager.reset_doors()
	var tw = create_tween()
	label.text = WeekDays[day]
	SignalManager.fear.emit(-50)
	tw.tween_property(label, "visible_ratio", 1.0, 0.5)
	player.global_position = starting_pos
	text_window.clear()
	await  tw.finished
	await fadein()
	label.text = ""
	
func starting_dialog():
	fade_out_rect.color.a = 1.0
	label.visible_ratio =0.0
	door_manager.reset_doors()
	var tw = create_tween()
	label.text = WeekDays[0]
	tw.tween_property(label, "visible_ratio", 1.0, 0.5)
	player.global_position = starting_pos
	text_window.clear()
	await  tw.finished
	await fadein()
	label.text = ""
	text_window.queue_text("Alright. IPR Archives. Time to get some answers")
func move_player(pos: Vector2):
	player.global_position = pos

func outro():
	await fadeout()
	##start scene
	player.reset_movement()
	label.text = "You succeded"
	await get_tree().create_timer(3).timeout
	SignalManager.text_full_on[1] = true
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
func fadeout():
	player.stop_movement()
	var tween_out = create_tween()
	tween_out.tween_property(fade_out_rect,"color:a", 1.0, 0.5)
	await tween_out.finished
func fadein():
	var tween_in = create_tween()
	tween_in.tween_property(fade_out_rect, "color:a", 0.0,0.5)
	await tween_in.finished
	player.start_movement()

func loose():
	await fadeout()
	label.text = "You lost \nIt's weekend and \nyou still have no answers \nTry again"
	await get_tree().create_timer(3).timeout
	label.text = ""
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
