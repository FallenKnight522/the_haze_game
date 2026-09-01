extends Area2D
@export var x_mod = 0
@onready var character_body_2d: CharacterBody2D = $"../CharacterBody2D"
signal exited

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.global_position.x += x_mod
		character_body_2d.global_position.x += x_mod
		SignalManager.fear.emit(1)
		exited.emit()
		if randf() < 0.1 && !character_body_2d.visible:
			character_body_2d.show_dan()
