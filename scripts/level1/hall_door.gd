extends the_haze_object
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var door_graphics: Node2D = $"../door graphics"
@onready var area_2d: Area2D = $"../../Area2D"
@onready var area_2d_2: Area2D = $"../../Area2D2"
@onready var Dan: the_haze_object = $"../../CharacterBody2D/the_haze_object"
const timerMax = 2
var orientation = randi_range(-10,10)
var not_changing_index = 0
var timer = 2.0
static var last_interact = null
static var file = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_hint()
	sprite_2d.texture = door_graphics.States[0]
	area_2d.exited.connect(change_plus)
	area_2d_2.exited.connect(change_minus)

func change_plus():
	orientation += 1
	change(true)
func change_minus():
	orientation -= 1
	change(true)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer -= delta
	if(timer <= 0 && randf() < 0.33):
		change(false)
	elif(timer <= 0):
		timer = randi_range(0, timerMax)
func change( change_room):
	timer = timerMax
	if orientation == 0:
		sprite_2d.texture = door_graphics.States[not_changing_index]
	elif(randf() < 0.05 && (orientation <-5 || orientation > 5) ):
		not_changing_index = randi_range(0,door_graphics.States.size()-1)
		orientation = 0
		sprite_2d.texture = door_graphics.States[not_changing_index]
	else:
		sprite_2d.texture = door_graphics.States[randi_range(0,door_graphics.States.size()-1)]
	if(self == last_interact && change_room):
		last_interact = null
static var interaction = 0
func interact():
	if !file && orientation == 0 && not_changing_index ==0:
		file = true
		SignalManager.download_file.emit("0x6C.txt")
	if(last_interact == self):
		interaction-=1
	else:
		Dan.door_opened()
	if(interaction < 2):
			SignalManager.show_text.emit("This door is locked. Maybe I should try some other")
	elif(interaction == 2):
			SignalManager.show_text.emit("This door is locked. No surprise there...")
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
