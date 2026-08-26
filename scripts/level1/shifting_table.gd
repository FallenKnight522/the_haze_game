extends the_haze_object
@export var States:Array[Texture2D] = []
@onready var sprite_2d: Sprite2D = $Sprite2D
var time = 0
const maxTime = 60

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_hint()
	if !States.is_empty():
		sprite_2d.texture = States[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time -= delta
	if time < 0:
		time = randi_range(1,maxTime)
		sprite_2d.texture = States[randi_range(1,States.size() - 1)]
		SignalManager.fear.emit(1)
func interact():
	SignalManager.show_text.emit("A normal table.. it looks like it is not fineshed yet")
	SignalManager.show_text.emit("Wait a minute... wasn't it just a moment ago...")
	SignalManager.fear.emit(1)
