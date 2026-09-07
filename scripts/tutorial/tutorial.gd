extends Node
@onready var text_window: CanvasLayer = %Text_window
@onready var character_body: CharacterBody2D = $"../Player"
@warning_ignore("shadowed_global_identifier")
@onready var hint: CanvasLayer = $"../Hint"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text_window.text_finished.connect(character_body.start_movement)
	text_window.text_started.connect(character_body.stop_movement)
	text_window.window_finished.connect(hint.windowLeft)
	text_window.queue_text('Welcome to "The Haze"\n(press Enter to continue)')
	text_window.queue_text('Tutorial: Press Enter to end interaction')
	text_window.queue_text('First press will show the entire text, second will move you to new window, or end interaction')
	text_window.queue_text('Tutorial: Press right arrow or D to go right\nThis works both in the map, and when choosing between options')
	text_window.queue_text('Tutorial: Press left arrow or A to go left\nThis works both in the map, and when choosing between options')
	text_window.queue_text('Tutorial: Press Space, upwards arrow or W to jump')
	text_window.queue_text('Tutorial: Press left mouse button, down arrow or S to interact\nInteraction will usually make text windows appear')
	text_window.queue_text('Tutorial: Press Q or Esc to leave to menu\nThe game will ask you to comfirm')
	text_window.queue_text("Whenever the game gives you a choice, choose with arrows/A and D and confirm with Enter.")
	text_window.queue_choice2("Example of a choice", "Option one", "Option Two")
	var arg: Array[String] = ["Option one", "Option Two", "Option Three"]
	var acctions: Array[Callable] = []
	text_window.queue_choice("Example of a choice with more options", arg, acctions)
	text_window.queue_text("When the game requests your input, just type in on the keyboard, and hit enter to confirm.")
	text_window.queue_input("Enter your game nick:")
	SignalManager.input_recieved.connect(next)
func next(context, responce):
	if(context == "Enter your game nick:"):
		SignalManager.input_recieved.disconnect(next)
		match responce:
			"kuba":
				text_window.queue_text("Did you mean: 'Kubabot' ?")
			"Kuba":
				text_window.queue_text("Did you mean: 'Kubabot' ?")
			"Jakub":
				text_window.queue_text("Did you mean: 'Kubabot' ?")
			"kubabot":
				text_window.queue_text("Did you mean: 'Kubabot' ?")
			"risa":
				text_window.queue_text("Did you mean: 'Richardosaurus' ?")
			"Risa":
				text_window.queue_text("Did you mean: 'Richardosaurus' ?")
			"Ríša":
				text_window.queue_text("Did you mean: 'Richardosaurus' ?")
			"richardosaurus":
				text_window.queue_text("Did you mean: 'Richardosaurus' ?")
			"Vojta":
				text_window.queue_text("Did you mean: 'SkurutHai' ?")
			"Vojtěch":
				text_window.queue_text("Did you mean: 'SkurutHai' ?")
			"vojta":
				text_window.queue_text("Did you mean: 'SkurutHai' ?")
			"vojtech":
				text_window.queue_text("Did you mean: 'SkurutHai' ?")
			"skuruthai":
				text_window.queue_text("Did you mean: 'SkurutHai' ?")
			"Skuruthai":
				text_window.queue_text("Did you mean: 'SkurutHai' ?")
			"skurutHai":
				text_window.queue_text("Did you mean: 'SkurutHai' ?")
			"vlocka":
				text_window.queue_text("Did you mean: 'Vlocka' ?")
			"paja":
				text_window.queue_text("Did you mean: 'Vlocka' ?")
			"Paja":
				text_window.queue_text("Did you mean: 'Vlocka' ?")
			"palva":
				text_window.queue_text("Did you mean: 'Vlocka' ?")
			"ema":
				text_window.queue_text("Did you mean: 'NemoIsLostAgain' ?")
			"Ema":
				text_window.queue_text("Did you mean: 'NemoIsLostAgain' ?")
			"nemo_nem":
				text_window.queue_text("Did you mean: 'NemoIsLostAgain' ?")
			"nemoislostagian":
				text_window.queue_text("Did you mean: 'NemoIsLostAgain' ?")
			"Kubabot":
				text_window.queue_text("I promised you would appear in my first game as a character.")
				text_window.queue_text("And in certain sence, I did keep that promise")
			"Richardosaurus":
				text_window.queue_text("I did not have time to test it properly...")
				text_window.queue_text("But you still can try to break it...")
			"SkurutHai":
				text_window.queue_text("Not exactly horror about the being hunted by conducter")
				text_window.queue_text("But at least its still horror...")
			"Vlocka":
				text_window.queue_text("Let see if you can find you're statement")
				text_window.queue_text("It is quite difficult")
			"NemoIsLostAgain":
				text_window.queue_text("Don't judge the graphics too hard please..")
				text_window.queue_text("(Most of them are made in Microsoft Draw... or from the internet)")
			"FallenKnight":
				text_window.queue_choice2("Seriously? Identity theft is real...", "Yes", "Yes, it is", end_all, end_all)
			"Brian":
				text_window.queue_text("No, you're not.")
				get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
			_:
				text_window.queue_text("Welcome to the game " + responce)
		text_window.queue_text("Disclaimer: This game is inspired by the world of The Magnus Archives audiodrama (for detail see License)")
		text_window.queue_text("Content Warning: The game features topics of loneliness and isolation.")
		text_window.queue_text("Now that you finished tutorial, why don't you go and say hi, to my assistant Spider.llm\nHe really wanted to greet the new players")
	print(context+ responce)
func end_all():
	get_tree().quit()
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("leave")): #Bit legacy code to put leaving into textbox, but since it will be there always, and it can be changed, I will keep it
		
		text_window.force_choice2("Do you want to return to the menu?", "Yes", "No", leave, stay)
		text_window.force_enabled = false
func leave():
	text_window.force_enabled = true
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
func stay():
	text_window.force_enabled = true
