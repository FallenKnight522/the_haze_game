extends the_haze_object
@onready var zrcadlo_4: TextureRect = $".."

var first = true
var fear_val = 0
const distorted_fear = 25
# Called when the node enters the scene tree for the first time.
func interact():
	if(first):
		SignalManager.show_text.emit("Just a normal .... wait, I don't have reflection in it.")
		first= false
	elif(fear_val < distorted_fear):
		SignalManager.show_text.emit("Is it a window into an identical room?")
		SignalManager.fear.emit(1)
	elif(fear_val > 90):
		SignalManager.download_file.emit("0x46.txt")
	else:
		SignalManager.show_text.emit("Is that some sort of funhouse window?")
		SignalManager.show_text.emit("Why is it so twisted?")
		SignalManager.fear.emit(5)
	
func twist(fear):
	zrcadlo_4.material.set_shader_parameter("fear_intensity", (fear/10)*(fear/10)*0.01)
	fear_val = fear
