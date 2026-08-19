extends Node
@onready var character_body: CharacterBody2D = %Player
@onready var text_window: CanvasLayer = %Text_window
@onready var hint: hint = %hint


@onready var rooms_container = $RoomContainer

# Zde si budeme ukládat místnosti. 
var ulozene_mistnosti: Dictionary = {}
# Odkaz na právě hranou místnost
var aktualni_mistnost: Node2D = null


func _ready() -> void:
	text_window.text_finished.connect(character_body.start_movement)
	text_window.text_started.connect(character_body.stop_movement)
	text_window.window_finished.connect(hint.windowLeft)
	SignalManager.show_text.connect(text_window.queue_text)
	SignalManager.show_choice2.connect(text_window.queue_choice2)
	SignalManager.change_room.connect(enter_room)
	text_window.force_enabled = true
	enter_room("obytny_pokoj", "res://scenes/rooms/Living_room.tscn")
	starting_dialog()
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("leave")): #Bit legacy code to put leaving into textbox, but since it will be there always, and it can be changed, I will keep it
		
		text_window.force_choice2("Do you want to return to the menu?", "Yes", "No", leave, stay)
		text_window.force_enabled = false
func leave():
	text_window.force_enabled = true
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
func stay():
	text_window.force_enabled = true


#Made by Spider.LLM
func enter_room(id_mistnosti: String, cesta_k_scene: String):
	# 1. ZBAVÍME SE STARÉ MÍSTNOSTI (ale nemažeme ji!)
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

	character_body.global_position = Vector2(-571, 0)
	
func starting_dialog():
	text_window.queue_text("Where... Where am I...")
	text_window.queue_text("Right.. I recall... we went to explore that strange house... did I get lost")
	text_window.queue_text("MARGARET?!! ALICE?!! DAN!!! Are you here? Can you hear me? ")
	text_window.queue_text("HELLO?!! ANYONE???")
	text_window.queue_text("I should find them as soon as I can... I have bad feeling about this place...")
	text_window.queue_text("(Exploring this place together was a bad idea... Why did I suggest it... I should have known it would't end well)")
	text_window.queue_text('(So much for "facing my fears"... )')

	
