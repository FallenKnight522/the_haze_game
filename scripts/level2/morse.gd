extends AnimatedSprite2D
@export var message: Array[String] = []
var pos = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_finished.connect(play_next)
	play("pause")
func play_next():
	pos = (pos + 1) % message.size()
	match message[pos]:
		".":
			play("short")
		"-":
			play("long")
		"/":
			play("pause")
		_:
			push_error("invalid character")
