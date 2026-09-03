extends Sprite2D
var hrac: Node2D = null

func _ready() -> void:
	# Nalezení hráče ve stromu scén
	hrac = get_tree().get_first_node_in_group("player") as Node2D

func _process(_delta: float) -> void:
	if hrac != null:
		look_at(hrac.global_position)
