extends Area2D

@export var gravity_dir: Vector2
static var fall = 0
const fall_to_fear_mod = 5
func _ready() -> void:
	fall = 0
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("change_gravity"):
		body.change_gravity(gravity_dir)
	if body.is_in_group("player"):
		fall+=1
		if(fall%fall_to_fear_mod == 0):
			SignalManager.fear.emit(fall/fall_to_fear_mod)
		match fall:
			1:
				SignalManager.show_text.emit("WHOAH.. what did just happen")
			5:
				SignalManager.show_text.emit("I think I am going to throw up... how is this possible")
				SignalManager.show_text.emit("Is the house spinning? Or the room? Or does gravity just not work here?")				
			20:
				SignalManager.show_text.emit("Whitch way is up again? I need to leave")
			40:
				SignalManager.show_text.emit("Need.. to ... get .. out... I... can't take this .. much .. longer")
			
