extends Area2D
class_name the_haze_object
@onready var label: Label = $Label
var can_interact = false
var interraction_allowed = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_hint() # Replace with function body.
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") && interraction_allowed:
		can_interact = true
		show_hint()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		can_interact = false
		hide_hint()
func turn_off():
	interraction_allowed = false
	can_interact = false
	hide_hint()

func show_hint():
	label.show()
func hide_hint():
	label.hide()
func _unhandled_input(event: InputEvent):
	# Pokud je hráč v dosahu a zmáčkne klávesu pro akci (např. Enter nebo E)
	if can_interact and event.is_action_pressed("interract") and !SignalManager.text_showing:
		interact()
		
func interact():
	pass
	
