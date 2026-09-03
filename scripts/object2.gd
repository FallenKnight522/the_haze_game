extends Area2D
class_name the_haze_object2
@onready var label: Label = $Label
var can_interact = false
var interraction_allowed = true
@export var Manager: Object_manager
@export var text: String
@export var texture: Texture2D
@export var texture_size: Vector2 = Vector2(1,1)
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var interraction_max: int
var interaction = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_hint() # Replace with function body.
	if(texture != null):
		sprite_2d.texture = texture
	sprite_2d.scale = texture_size
func _process(delta: float) -> void:
	if(texture != null):
		sprite_2d.texture = texture
	sprite_2d.scale = texture_size
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") && interraction_allowed:
		can_interact = true
		show_hint()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		can_interact = false
		hide_hint()
		
func show_hint():
	label.show()
func hide_hint():
	label.hide()
func _unhandled_input(event: InputEvent):
	# Pokud je hráč v dosahu a zmáčkne klávesu pro akci (např. Enter nebo E)
	if can_interact and event.is_action_pressed("interract"):
		interact()
		
func interact():
	Manager.interaction(text, interaction, self)
	if interaction < interraction_max:
		interaction+=1
	
