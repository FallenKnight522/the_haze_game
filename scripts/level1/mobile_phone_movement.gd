extends CharacterBody2D


##Made with Spider LLM
var gravity_mod: Vector2 = Vector2.LEFT

func _physics_process(delta: float) -> void:
	
	velocity += get_gravity().length() * delta*gravity_mod
	move_and_slide()
func change_gravity(grav: Vector2):
	gravity_mod = grav
	rotation = gravity_mod.angle() - (PI / 2.0)
