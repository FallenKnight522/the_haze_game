extends CharacterBody2D
var hrac: Node2D = null
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	hrac = get_tree().get_first_node_in_group("player") as Node2D

func _physics_process(delta: float) -> void:
	global_position = hrac.global_position
	if Input.is_action_just_pressed("jump") and hrac.is_on_floor():
		animated_sprite.play("jump_start")
	var direction := Input.get_axis("move left", "move right")
	direction*=hrac.move_modifier
	if direction > 0:
		animated_sprite.flip_h = false;
	elif direction < 0:
		animated_sprite.flip_h = true;
	if hrac.is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("fall")
