extends Area2D

@export var where: Vector2
@onready var spiral_room: Node2D = $".."
@export var down: bool



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		SignalManager.move_player.emit(where)
		var r = randf()
		spiral_room.went(down)
		if r < 0.05:
			spiral_room.Margaret_section()
		elif r < 0.2:
			spiral_room.door_section()
		else:
			spiral_room.empty_section()
