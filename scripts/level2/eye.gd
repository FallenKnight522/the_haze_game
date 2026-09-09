extends Control
##made with spider llm

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
# Paměť samotného oka (ví, jaký je jeho aktuální stav)
var is_open: bool = false 
var fear = 0.0

func _ready() -> void:
	# Výchozí stav je prázdný obrázek (předpokládáme, že animace "close" končí prázdnem)
	anim_sprite.play("idle")
	anim_sprite.rotation = randi_range(-180,180)
	timer.wait_time = randf_range(8.0, 12.0)
	timer.start()
	SignalManager.fear_changed.connect(change_fear)
# Tuto funkci zavolá centrální program jednou za čas
func check_state(fear_level: float) -> void:
	# Rozhodnutí, zda zde oko MÁ být (na základě strachu)
	# randf() vygeneruje číslo od 0.0 do 1.0. 
	var should_be_open: bool = randf() < fear_level
	
	if should_be_open and not is_open:
		# Pravidlo 4: Má tam být a není -> Otevři se
		anim_sprite.play("open")
		is_open = true
		
	elif not should_be_open and is_open:
		# Pravidlo 3: Nemá tam být a je -> Zavři se
		anim_sprite.play("close")
		is_open = false
		
	# Pravidlo 1 a 2: Pokud se stavy shodují (should_be_open == is_open),
	# kód neudělá nic. Oko zůstává zírat, nebo zůstává skryté.

func change_fear(_fear):
	fear = _fear
func _on_timer_timeout() -> void:
	check_state(fear/100.0)
