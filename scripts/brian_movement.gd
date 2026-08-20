extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -500.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var move_modifier = 1
var gravity_modifie = Vector2.DOWN

func _ready() -> void:
	add_to_group("player")
func _physics_process(delta: float) -> void:
	var local_velocity = velocity.rotated(-rotation) ## local velocity so it funcitons regardless of gravity
	# Add the gravity.
	if not is_on_floor():
		local_velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		animated_sprite.play("jump_start")
		local_velocity.y = JUMP_VELOCITY* move_modifier

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move left", "move right")
	direction*=move_modifier
	
	if direction > 0:
		animated_sprite.flip_h = false;
	elif direction < 0:
		animated_sprite.flip_h = true;
	
	#Animation
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("fall")
	
	if direction:
		local_velocity.x = direction * SPEED
	else:
		local_velocity.x = move_toward(velocity.x, 0, SPEED)
	velocity = local_velocity.rotated(rotation)
	move_and_slide()

func stop_movement():
	var local_velocity = velocity.rotated(-rotation) ## local velocity so it funcitons regardless of gravity
	local_velocity.x = 0
	velocity = local_velocity.rotated(rotation)
	move_modifier = 0
func start_movement():
	move_modifier = 1
func change_gravity(grav: Vector2):
	gravity_modifie = grav
	up_direction = -gravity_modifie
	rotation = gravity_modifie.angle() - (PI / 2.0)
	
