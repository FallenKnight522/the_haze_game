extends Node
@onready var text_window: CanvasLayer = %Text_window
@onready var character_body: CharacterBody2D = $"../Player"
@onready var hint: CanvasLayer = $"../Hint"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text_window.text_finished.connect(character_body.start_movement)
	text_window.text_started.connect(character_body.stop_movement)
	text_window.window_finished.connect(hint.windowLeft)
	text_window.queue_text('Welcome to "The Haze"
(press Enter to continue)')
	text_window.queue_text('Tutorial: Press Enter to end interraction')
	text_window.queue_text('First press will show the entire text, seccond will move you to new window, or end interraction')
	text_window.queue_text('Tutorial: Press right arrow or D to go right
This works both in the map, and when choosing between options')
	text_window.queue_text('Tutorial: Press left arrow or A to go left
This works both in the map, and when choosing between options')
	text_window.queue_text('Tutorial: Press Space, upwards arrow or W to jump')
	text_window.queue_text('Tutorial: Press left mouse button, down arrow or S to interract
Interraction will usually make text windows appear')
	text_window.queue_text('Tutorial: Press Q or Esc to leave to menu
The game will ask you to comfirm')
	text_window.queue_text("Whenever the game gives you a choice, choose with arrows/A and D and comfirm with Enter.")
	text_window.queue_choice2("Example of a choice", "Option one", "Option Two")
	text_window.queue_text("Disclaimer: This game is inspired by the world of The Magnus Archives audiodrama (for detail see License)")
	text_window.queue_text("Content Warning: The game features topics of lonelyness and isolation.")
	text_window.queue_text("Now that you finished tutorial, why don't you go and say hi, to my assistent Spider.llm
	He really wanted to greet the new players")
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("leave")): #Bit legacy code to put leaving into textbox, but since it will be there always, and it can be changed, I will keep it
		
		text_window.force_choice2("Do you want to return to the menu?", "Yes", "No", leave, stay)
		text_window.force_enabled = false
func leave():
	text_window.force_enabled = true
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
func stay():
	text_window.force_enabled = true
