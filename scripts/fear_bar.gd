extends TextureRect

@export var fear_levels: Array[Texture2D] = []
var fear = 0
const fearMax = 99
const fearLevels = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.fear.connect(on_fear)
	fear = 0
	if(!fear_levels.is_empty()):
		texture = fear_levels[0]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
func on_fear(val):
	SignalManager.fear_changed.emit(fear)
	var dec = fear/fearLevels
	fear += val
	if(fear >= fearMax):
			fear = fearMax
	if(fear/fearLevels != dec):
		showpicture()
func showpicture():
	if fear_levels.is_empty():
		return
	texture = fear_levels[clampi(fear/fearLevels,0, fearMax/fearLevels)]
		
	
		
