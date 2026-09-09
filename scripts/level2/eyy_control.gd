extends Control
# made by spider.llm
# Simulace tvé Strachomíry (hodnota 0.0 až 1.0)
@export var current_fear_level: float = 0.0 

# Spustí se každé 2 vteřiny (nebo dle nastavení Timeru)
func _on_timer_timeout() -> void:
	# Projdeme všechny 4 okrajové kontejnery
	for eye_slot in get_children():
		if eye_slot.has_method("check_state"):
			# Každé oko si hodí kostkou a vyhodnotí tvá 4 pravidla
			eye_slot.check_state(current_fear_level)
	print("calling")
