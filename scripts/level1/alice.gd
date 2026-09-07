extends Node2D
var hrac: Node2D = null
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var offset: Vector2 = Vector2(0,0)

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _ready() -> void:
	hrac = get_tree().get_first_node_in_group("player") as Node2D

func _physics_process(_delta: float) -> void:
	if(hrac == null):
		return
	var direction := Input.get_axis("move left", "move right")
	direction*=hrac.move_modifier
	global_position = hrac.global_position 
	if direction > 0:
		animated_sprite.flip_h = false;
	elif direction < 0:
		animated_sprite.flip_h = true;
	if hrac.is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
			global_position += offset
		else:
			global_position += offset * direction
			animated_sprite.play("run")
	else:
		global_position += offset * direction
		animated_sprite.play("fall")
