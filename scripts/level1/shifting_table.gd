extends the_haze_object
@export var States:Array[Texture2D] = []
@onready var sprite_2d: Sprite2D = $Sprite2D
var time = 0
var state = 0
var states_seen: Array[int] = []
const maxTime = 12

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_hint()
	if !States.is_empty():
		state = 0
		change_texture()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time -= delta
	if time < 0 && !States.is_empty():
		time = randi_range(1,maxTime)
		state = randi_range(1,States.size()) - 1
		change_texture()
		SignalManager.fear.emit(1)
func interact():
	match state:
		0:
			SignalManager.show_text.emit("A simple plastic table. Looks unfinished.")
			markstate()
		1:
			SignalManager.show_text.emit("A firm wooden table, for larger families.")
			SignalManager.show_text.emit("Wasn't it.. just a moment ago...")
			markstate()
		2:
			SignalManager.show_text.emit("A metal garden table, looks lovely.")
			SignalManager.show_text.emit("Wait.. somethings off...")
			markstate()
		3:
			SignalManager.show_text.emit("A small bedside table... wasn't the table larger a moment ago")
			markstate()
		4:
			SignalManager.show_text.emit("A massive, beautiful table. Looks like it belongs to a castle or museum.")
			SignalManager.show_text.emit("How did I not notice it earlier?")
			markstate()
		_:
			SignalManager.show_text.emit("A normal table... it looks like it is not finished yet.")
			SignalManager.show_text.emit("Wait a minute... wasn't it different just a moment ago?")
func change_texture():
	sprite_2d.texture = States[state]
func markstate():
	if not states_seen.has(state):
		states_seen.append(state)
		if(states_seen.size() == States.size()):
			SignalManager.download_file.emit("0x6D.txt")
