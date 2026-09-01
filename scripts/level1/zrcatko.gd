extends TextureRect
#Made with Spider.LLM
# Získáme odkazy na naše vnitřní uzly
@onready var camera_2d: Camera2D = $SubViewport/Camera2D
@onready var sub_viewport: SubViewport = $SubViewport
@onready var marker_2d: Marker2D = $Marker2D
func _ready() -> void:
	# 1. Při startu automaticky propojíme zrcadlo s hlavním herním světem
	# (Tím odpadá nutnost to psát do skriptu celé místnosti)
	sub_viewport.world_2d = get_viewport().world_2d
	texture = sub_viewport.get_texture()
	camera_2d.global_position = marker_2d.global_position
						
