extends Area2D
@onready var matylda: the_haze_object2 = $".."

var active = true



func _on_body_entered(body: Node2D) -> void:
	if active && body.is_in_group("player") && matylda.interraction_allowed && matylda.Manager.flags.has("phone") && matylda.Manager.flags["phone"] == 1:
		matylda.Manager.interaction("caught", 0, matylda)
		active = false
