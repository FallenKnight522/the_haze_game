extends Node
@onready var text_window: CanvasLayer = %Text_window
@onready var hint_: hint = %hint
@onready var player: CharacterBody2D = %Player
@onready var rooms_container = $RoomContainer
@onready var color_rect: ColorRect = $Colours/ColorRect
@onready var file_manager: Node2D = %FileManager
@onready var fade_out_rect: ColorRect = $Colours2/ColorRect

# Zde si budeme ukládat místnosti. 
var ulozene_mistnosti: Dictionary = {}
# Odkaz na právě hranou místnost
var aktualni_mistnost: Node2D = null
const fear_to_colour= 0.5*0.01

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
	SignalManager.fear_limit.connect(outro)
	SignalManager.fear_changed.connect(colors)
	SignalManager.download_file.connect(file_manager.extrah_zip)
	text_window.force_enabled = true
	colors(0)
	await enter_room("obytny_pokoj", "res://scenes/rooms/Living_room.tscn")
	starting_dialog()
					
	
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("leave") && text_window.force_enabled): #Bit legacy code to put leaving into textbox, but since it will be there always, and it can be changed, I will keep it
		
		text_window.force_choice2("Do you want to return to the menu?", "Yes", "No", leave, stay)
		text_window.force_enabled = false
func colors(fear_num):
	color_rect.material.set_shader_parameter("fear_intensity", fear_num * fear_to_colour)
func leave():
	await get_tree().process_frame
	text_window.force_enabled = true
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
func stay():
	await get_tree().process_frame
	text_window.force_enabled = true


#Made by Spider.LLM
func enter_room(id_mistnosti: String, cesta_k_scene: String):
	player.global_position = Vector2(-571, 0)
	# 1. ZBAVÍME SE STARÉ MÍSTNOSTI (ale nemažeme ji!)
	player.reset_movement()
	text_window.clear()
	if aktualni_mistnost != null:
		rooms_container.remove_child(aktualni_mistnost)

	# 2. NAHRAJEME NOVOU (NEBO ULOŽENOU) MÍSTNOST
	if ulozene_mistnosti.has(id_mistnosti):
		# the room is already loaded
		aktualni_mistnost = ulozene_mistnosti[id_mistnosti]
		rooms_container.add_child(aktualni_mistnost)
	else:
		var nova_scena = load(cesta_k_scene)
		aktualni_mistnost = nova_scena.instantiate()
		
		ulozene_mistnosti[id_mistnosti] = aktualni_mistnost
		
		rooms_container.add_child(aktualni_mistnost)
	player.reset_movement()
	await fadeout()
	await fadein()
	player.global_position = Vector2(-571, 0)
	
func starting_dialog():
	text_window.queue_text("Where... Where am I...")
	text_window.queue_text("Right.. I recall... we went to explore that strange house... did I get lost?")
	text_window.queue_text("MARGARET?!! ALICE?!! DAN!!! Are you here? Can you hear me?")
	text_window.queue_text("HELLO?!! ANYONE???")
	text_window.queue_text("I should find them as soon as I can... I have a bad feeling about this place...")
	text_window.queue_text("(Exploring this place together was a bad idea... Why did I suggest it... I should have known it wouldn't end well)")
	text_window.queue_text('(So much for "facing my fears"... )')
func move_player(pos: Vector2):
	player.global_position = pos

func outro():
	player.global_position = Vector2(-571, 0)
	await fadeout()
	if(aktualni_mistnost != null):
			rooms_container.remove_child(aktualni_mistnost)
	var nova_scena = load("res://scenes/rooms/grass.tscn")
	aktualni_mistnost = nova_scena.instantiate()
	rooms_container.add_child(aktualni_mistnost)
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
