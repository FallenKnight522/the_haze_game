extends CharacterBody2D

@export var rychlost_plizeni: float = 5.0 
@export var max_vzdalenost: int = 2

# 2. VNITŘNÍ PROMĚNNÉ
var hrac: Node2D = null
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var shown = false
func _ready() -> void:
	hrac = get_tree().get_first_node_in_group("player") as Node2D
	hide()
func show_dan():
	if(!shown):
		show()
		shown = true
		global_position = Vector2(63,-29)
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Pokud hráč neexistuje (např. se ještě nenačetl), nic neděláme
	if not hrac:
		hrac = get_tree().get_first_node_in_group("player") as Node2D
		move_and_slide()
		return

	var vzdalenost = global_position.distance_to(hrac.global_position)
	if(vzdalenost > max_vzdalenost ):
		if(global_position.direction_to(hrac.global_position).x < 0):
			animated_sprite_2d.flip_h = true
		else:
			animated_sprite_2d.flip_h = false
		velocity.x = rychlost_plizeni  * global_position.direction_to(hrac.global_position).x
		move_and_slide()
		animated_sprite_2d.play("run")
	else:
		velocity.x = 0
		animated_sprite_2d.play("idle")
		move_and_slide()
