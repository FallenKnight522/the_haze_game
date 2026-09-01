extends Node2D
@onready var opened_door_: the_haze_object = $opened_door
@onready var closed_door: the_haze_object = $closed_door
@onready var tile_map_layer: TileMapLayer = $Labirinth/TileMapLayer
@onready var tile_map_layer_2: TileMapLayer = $Labirinth/TileMapLayer2
@onready var tile_map_layer_3: TileMapLayer = $Labirinth/TileMapLayer3
@onready var animation_player: AnimationPlayer = $CanvasLayer/AnimationPlayer
var maps = []
var timer: float = 0.0
const timerMax = 10.0
var change = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	maps.push_back(tile_map_layer)
	maps.push_back(tile_map_layer_2)
	maps.push_back(tile_map_layer_3)
	set_map()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if(timer > timerMax):
		timer = 0.0
		change+=1
		set_map()
func set_map():
	animation_player.play("glitch_transition")
	await get_tree().create_timer(0.5).timeout
	if not is_inside_tree():
		return
	for i in range(3):
		maps[i].collision_enabled = false
		maps[i].hide()
	var rnd = randf() 
	if rnd <0.33:
		maps[0].collision_enabled = true
		maps[0].show()
	elif rnd <0.66:
		maps[1].collision_enabled = true
		maps[1].show()
	else:
		maps[2].collision_enabled = true
		maps[2].show()
	if rnd  < 0.5:
		opened_door_.position = Vector2(-566,-45)
		closed_door.position = Vector2(430,-617)
		closed_door.behind_player = false
	else:
		closed_door.position = Vector2(-566,-45)
		opened_door_.position = Vector2(430,-617)
	match change:
		1:
			SignalManager.show_text.emit("Wait... I thought.. Was that platform not...")
		5:
			SignalManager.show_text.emit("Is the room moving? Is there some mechanism I am not seeing?")
			SignalManager.fear.emit(5)
		10:
			SignalManager.show_text.emit("Yes, yes, there must be a pattern. Just watch closely, time it right, and you can predict it.")
			SignalManager.fear.emit(5)
		15:		
			SignalManager.show_text.emit("It... it cannot be random... no... the mechanism must have logic... the room cannot change on its own...")
			SignalManager.fear.emit(10)
		_:
			SignalManager.fear.emit(1)
