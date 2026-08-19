extends CanvasLayer
class_name hint
@export var selected: Array[Texture2D] = []
var selected1 = true
@onready var texture_rect: TextureRect = $MarginContainer/TextureRect
@onready var button: Button = $MarginContainer/Button
var showing = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	selected1 = true
	if(!selected.is_empty()):
		texture_rect.texture = selected[0]


func _on_button_pressed() -> void:
	if(showing):
		return
	showing = true
	if(!selected.is_empty()):
			texture_rect.texture = selected[1]
	showHint()
func showHint():
	push_warning("Hint not overriten")
func hideHint():
	if(!selected.is_empty()):
		texture_rect.texture = selected[0]
	showing = false
