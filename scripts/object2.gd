extends the_haze_object
class_name the_haze_object2
@export var Manager: Object_manager
@export var text_default: String = "default"
@export var text_special: Dictionary[int, String]
@export var texture: Texture2D
@export var texture_size: Vector2 = Vector2(1,1)
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var interraction_max: int
@export var hide_final_interaction: bool = false
@export var hide_when_no_custom: bool = false
var interaction = 0
signal act(action: int)
var interraction_special = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_hint() # Replace with function body.
	if(texture != null):
		sprite_2d.texture = texture
	sprite_2d.scale = texture_size
	Manager.new_day.connect(reset_day)
func _process(delta: float) -> void:
	if(texture != null):
		sprite_2d.texture = texture
	sprite_2d.scale = texture_size
func reset_day(day):
	interraction_allowed = true
	show()
	if text_special.has(day):
		interraction_special = 0
	elif hide_when_no_custom: # for those only for specific days
		turn_off()
		hide()
func interact():
	if text_special.has(Manager.day):
		Manager.interaction(text_special[Manager.day], interraction_special, self)
		if interraction_special < interraction_max:
			interraction_special+=1
	else:
		Manager.interaction(text_default, interaction, self)
		if interaction < interraction_max:
			interaction+=1
		elif(hide_final_interaction):
			turn_off()
	
