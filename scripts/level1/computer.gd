extends the_haze_object
@onready var monitor: CharacterBody2D = $"../../Monitor"


var inter = 1
var file = false

func interact():
	match inter:
		1:
			SignalManager.show_text.emit("A computer. It does not seem to turn on.")
		2:
			SignalManager.show_text.emit("Maybe if you open the case and check the wires, you could get it working.")
			file = true
			SignalManager.show_text.emit("Looks like it is running, good job. Now it just needs a monitor")
		3:
			SignalManager.fear.emit(5)
			SignalManager.show_text.emit("Why is the case BLEEDING?")
		4:
			SignalManager.show_text.emit("IT CAN TALK??")
			SignalManager.show_text.emit('"The sharp edges hurt my mind. Free me!"')
			SignalManager.fear.emit(10)
		_:
			SignalManager.show_text.emit("Not touching that again")
			inter -=1
	inter +=1


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") && interraction_allowed:
		can_interact = true
		show_hint()
	elif(body == monitor && file):
		file = false
		SignalManager.download_file.emit("0x41.txt")
