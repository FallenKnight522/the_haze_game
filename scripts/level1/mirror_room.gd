extends Node2D
@onready var zrcadlo_alice: TextureRect = $ZrcadloAlice
@onready var sub_viewport: SubViewport = $ZrcadloAlice/SubViewport


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sub_viewport.world_2d = get_viewport().world_2d


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
