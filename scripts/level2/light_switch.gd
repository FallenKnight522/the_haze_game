extends the_haze_object
@export var Manager: Object_manager
var light = true
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var level_2: Node2D = $"../.."
@onready var jan: the_haze_object2 = $"../people/Jan"
const Jan_startpos = Vector2(-1031,-1079)
const Jan_trappos = Vector2(-1447,-1087)

func _ready() -> void:
	hide_hint()
	jan.global_position = Jan_startpos
	Manager.new_day.connect(reset_jan)
	sprite_2d.hide()
func interact():
	light = !light
	if light:
		sprite_2d.hide()
	else:
		sprite_2d.show()
		if jan.global_position == Jan_trappos:
			jan_trapped()
func trap():
	await get_tree().create_timer(2).timeout
	await level_2.fadeout()
	if light == false:
		interact()
	jan.global_position = Jan_trappos
	await level_2.fadein()
	SignalManager.show_text.emit("It does not take long, and Jan is enjoying your coffe in the small office")
func reset_jan(_day):
	jan.global_position = Jan_startpos
func jan_trapped():
	SignalManager.show_text.emit("Jan: No, its all comming back to me")
	SignalManager.show_text.emit("Jan: [Sobbing] Please, no more")
	SignalManager.show_choice2.emit("Jan: Turn on the light.. please..", "Turn on the light", "Keep him in the darkness", lighton, darkness)

func lighton():
	interact()
	await level_2.fadeout()
	jan.global_position = Jan_startpos
	SignalManager.show_text.emit("Jan quicly leaves the room")
	await level_2.fadein()
	SignalManager.show_text.emit("Thank you Brian.. I nearly went through all thouse painfull memories again")
	Manager.flags["light"] = 0
func darkness():
	SignalManager.show_text.emit("You leave Jan, to in the dark, until pleads turn into crying")
	await get_tree().create_timer(1).timeout
	interact()
	await level_2.fadeout()
	jan.global_position = Jan_startpos
	await level_2.fadein()
	SignalManager.show_text.emit("When you finally let him out, he is shivering.")
	SignalManager.show_text.emit("At first he wants to go and hide the statement somewhere new")
	SignalManager.show_text.emit("But then he changes his mind")
	SignalManager.show_text.emit("Jan: Since you were so curious, take it.")
	SignalManager.show_choice2.emit("Let's see how you like being haunted by shadows", "Take it", "Refuse", ending)
	Manager.flags["nightmare"] = 0
func ending():
	SignalManager.fear.emit(30)
	SignalManager.download_file.emit("0x387FFFFC.txt")
	Manager.transition()
