extends CharacterBody2D
# Made with Spider.LLM

@export var rychlost_plizeni: float = 5.0 
@export var vzdalenost_pro_strach: float = 80.0 
@export var strach_interval: float = 2.0 
@export var movedMin: int = 2
@export var vzdalenost_probuzeni: float = 120.0
@export var movedDiv: int = 2

# 2. VNITŘNÍ PROMĚNNÉ
var hrac: Node2D = null
var casovac_strachu: float = 0.0
var moved = 0
var je_probuzeny: bool = false
var fear_level = 0.1
var moveDirect = Vector2.ZERO

func _ready() -> void:
	SignalManager.fear_changed.connect(fear_changed)
	hrac = get_tree().get_first_node_in_group("player") as Node2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Pokud hráč neexistuje (např. se ještě nenačetl), nic neděláme
	if not hrac:
		hrac = get_tree().get_first_node_in_group("player") as Node2D
		move_and_slide()
		return

	var vzdalenost = global_position.distance_to(hrac.global_position)
	var smer = global_position.direction_to(hrac.global_position)
	if not je_probuzeny:
			if vzdalenost <= vzdalenost_probuzeni:
				je_probuzeny = true # Nábytek si ho všiml! Začíná se hýbat natrvalo.
			else:
				move_and_slide()
				return
	var old_distance = global_position
	moveDirect = velocity
	velocity += smer * rychlost_plizeni * fear_level
	move_and_slide()
	velocity = moveDirect
	moved +=  old_distance.distance_to(global_position)

	if vzdalenost <= vzdalenost_pro_strach && moved > movedMin:
		casovac_strachu += delta
		if casovac_strachu >= strach_interval:
			casovac_strachu = 0.0
			# Vyšleme signál přes náš Event Bus do Strachomíry!
			SignalManager.fear.emit(moved/movedDiv)
	else:
		casovac_strachu = 0.0
func fear_changed(level):
		fear_level = 0.01+ level/100.0
