extends Area2D
@export var x_mod = 0
signal exited

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.global_position.x += x_mod
		exited.emit()
