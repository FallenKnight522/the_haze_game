extends Node2D
@onready var zrcadlo_alice: TextureRect = $ZrcadloAlice
@onready var sub_viewport: SubViewport = $ZrcadloAlice/SubViewport
@onready var alice_obj: the_haze_object = $ZrcadloAlice/the_haze_object2
@onready var mirror4_obj: the_haze_object = $Zrcadlo4/the_haze_object

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.fear_changed.connect(alice_obj.twist)
	SignalManager.fear_changed.connect(mirror4_obj.twist)
	alice_obj.twist(0)
	mirror4_obj.twist(0)
