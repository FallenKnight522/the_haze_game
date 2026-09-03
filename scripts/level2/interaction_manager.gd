extends Object_manager

@onready var level_2: Node2D = $".."
@onready var fear: CanvasLayer = %Fear
var day = 0
const workdesk_position = Vector2(1592,-1046)

func interaction(_name: String, _interaction: int, _caller: Node):
	if dialog != null:
			match _name:
				"test":
					SignalManager.fear.emit(10)
				"clock":
					SignalManager.show_text.emit("It's " + get_time())
				_:
					SignalManager.show_dialog.emit(dialog, _name + str(_interaction), self)
	else:
			push_error("Dialog not loaded")
func stop_timer():
	den_aktivni = false
func transition():
	await level_2.fadeout()
	SignalManager.move_player.emit(workdesk_position)
	await level_2.fadein()


##Made with spider.llm
const DELKA_DNE_SEKUNDY = 240.0 # 4 reálné minuty
const LATE = 225.0 # 4 reálné minuty
const HERNICH_MINUT_ZA_SEKUNDU = 2.0 # 1 sekunda = 2 minuty[cite: 1]
var latemsg = true

var ubehly_cas: float = 0.0
var den_aktivni: bool = true

func _process(delta: float) -> void:
	if not den_aktivni:
		return
		
	ubehly_cas += delta
	if ubehly_cas >= DELKA_DNE_SEKUNDY:
		end_day()
	elif ubehly_cas >= LATE && latemsg:
		SignalManager.show_text.emit("It's getting late. I will need to go home soon.")
		latemsg = false
# Funkce, kterou mohou zavolat objekty (např. Hodiny), aby zjistily čas
func get_time() -> String:
	var celkem_hernich_minut = int(ubehly_cas * HERNICH_MINUT_ZA_SEKUNDU)
	
	# Předpokládáme, že 4hodinový blok (240 real. sekund * 2 = 480 herních minut) 
	# končí v 16:00[cite: 1]. Začátek je tedy v 08:00.
	var hodiny = 8 + (celkem_hernich_minut / 60)
	var minuty = celkem_hernich_minut % 60
	
	# Formátování do tvaru HH:MM (např. 09:05)
	return "%02d:%02d" % [hodiny, minuty]

func end_day():
	den_aktivni = false

	# Resetujeme časovač pro další den
	day+=1
	if day >= 5:
		await level_2.loose()
	else:
		await level_2.new_day(day)
	latemsg = true
	ubehly_cas = 0.0
	den_aktivni = true
		
