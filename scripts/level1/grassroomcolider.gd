extends Area2D
@export var x_mod = 0
signal exited
@onready var sprite_2d_2: Sprite2D = $"../Sprite2D2"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.global_position.x += x_mod
		exited.emit()
