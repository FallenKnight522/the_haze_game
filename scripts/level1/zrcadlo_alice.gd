extends TextureRect
#Made with Spider.LLM
# Získáme odkazy na naše vnitřní uzly
@onready var camera_2d: Camera2D = $SubViewport/Camera2D
@onready var sub_viewport: SubViewport = $SubViewport

func _ready() -> void:
	# 1. Při startu automaticky propojíme zrcadlo s hlavním herním světem
	# (Tím odpadá nutnost to psát do skriptu celé místnosti)
	sub_viewport.world_2d = get_viewport().world_2d

func _process(_delta: float) -> void:
	# 2. Neustále počítáme střed našeho UI plátna.
	# Vezmeme globální pozici (levý horní roh) a přičteme přesnou polovinu velikosti (size)
	var stred_ui = global_position + (size / 2.0)
	stred_ui.y += 5
	# 3. Kameru uvnitř Viewportu "přilepíme" na tento střed
	camera_2d.global_position = stred_ui
