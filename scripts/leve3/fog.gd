extends Sprite2D
@export var Manager: Object_manager
@export var day_appear: int = 8


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	Manager.new_day.connect(appear)
func appear(day: int):
	if day >= day_appear:
		show()
	else:
		hide()
