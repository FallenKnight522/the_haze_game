extends the_haze_object
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var door_graphics: Node2D = $"../door graphics"
@onready var area_2d: Area2D = $"../../Area2D"
@onready var area_2d_2: Area2D = $"../../Area2D2"
@onready var Dan: the_haze_object = $"../../CharacterBody2D/the_haze_object"
const timerMax = 2.0
var timer = timerMax
static var last_interact = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_hint()
	sprite_2d.texture = door_graphics.States[0]
	area_2d.exited.connect(change)
	area_2d_2.exited.connect(change)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func change():
	timer = timerMax
	sprite_2d.texture = door_graphics.States[randi_range(0,door_graphics.States.size()-1)]
	if(self == last_interact):
		last_interact = null
static var interaction = 0
func interact():
	if(last_interact == self):
		interaction-=1
	else:
		Dan.door_opened()
	if(interaction < 2):
			SignalManager.show_text.emit("This door is locked. Maybe I should try some other")
	elif(interaction == 2):
			SignalManager.show_text.emit("This door is locked. No suprise there...")
	elif(interaction < 5):
		SignalManager.show_text.emit("And another locked door.")
		SignalManager.fear.emit(1)
	elif(interaction < 20):
		SignalManager.show_text.emit("And another. It's like all of them are locked.")
		SignalManager.fear.emit(1)
	else:
		SignalManager.fear.emit(1)
		SignalManager.show_text.emit("Also locked...I am not sure I should even bother checking anymore...")
	interaction+=1
	last_interact = self
