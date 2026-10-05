extends Node
@onready var text_window: CanvasLayer = %Text_window
@onready var hint_: hint = %hint
@onready var player: CharacterBody2D = %Player
@onready var color_rect: ColorRect = $Colours/ColorRect
@onready var file_manager: Node2D = %FileManager
@onready var fade_out_rect: ColorRect = $Colours2/ColorRect
@onready var shadows: ColorRect = $Manger/Props/shadow

# Zde si budeme ukládat místnosti. 
var ulozene_mistnosti: Dictionary = {}
# Odkaz na právě hranou místnost
var aktualni_mistnost: Node2D = null
const fear_to_colour= 0.015

func _ready() -> void:
	get_viewport().canvas_cull_mask &= ~8
	text_window.text_finished.connect(player.start_movement)
	text_window.text_started.connect(player.stop_movement)
	text_window.window_finished.connect(hint_.windowLeft)
	SignalManager.show_text.connect(text_window.queue_text)
	SignalManager.show_choice2.connect(text_window.queue_choice2)
	SignalManager.change_room.connect(enter_room)
	SignalManager.show_dialog.connect(text_window.queue_dialog)
	SignalManager.move_player.connect(move_player)
	SignalManager.fear_limit.connect(enter_room)
	SignalManager.fear_changed.connect(colors)
	SignalManager.download_file.connect(file_manager.extrah_zip)
	text_window.force_enabled = true
	colors(0)
	shadows.color.a = 0.75
	shadows.hide()
	starting_dialog()
					
	
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("leave") && text_window.force_enabled): #Bit legacy code to put leaving into textbox, but since it will be there always, and it can be changed, I will keep it
		
		text_window.force_choice2("Do you want to return to the menu?", "Yes", "No", leave, stay)
		text_window.force_enabled = false
func colors(fear_num):
	color_rect.material.set_shader_parameter("strachomira", fear_num * fear_to_colour)
func leave():
	await get_tree().process_frame
	text_window.force_enabled = true
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
func stay():
	await get_tree().process_frame
	text_window.force_enabled = true


#Made by Spider.LLM
func enter_room(id_mistnosti: String = "lonely", cesta_k_scene: String = ""):
	player.global_position = Vector2(-571, -25)
	text_window.clear()
	player.reset_movement()
	match id_mistnosti:
		"spiral":
			await fadeout()
			get_tree().change_scene_to_file("res://scenes/rooms/Endless_hall.tscn")
		"lonely":
			await fadeout()
			get_tree().change_scene_to_file("res://scenes/rooms/Lonely.tscn")
		"memory":
			shadows.show()
			await fadein()
			player.stop_movement()
		"room":
			await  fadein()
			player.start_movement()
			shadows.hide()
		_:
			push_error("Invalid room")
	
func starting_dialog():
	text_window.queue_text("Alright.. It's time to make this game..")
	text_window.queue_text("Sadly, it looks like it's all up to me")
	text_window.queue_text("Spider.llm: And me! I'll help you!!")
	text_window.queue_text("I suppose... Alright, lets get to it")
	await outro()
	player.stop_movement()
func move_player(pos: Vector2 = Vector2(-571, -25)):
	player.global_position = pos
func loose():
	pass

func new_day(_day):
	await  fadeout()
	move_player
	await  fadein()

func outro():
	move_player
	await fadein()
	move_player
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
