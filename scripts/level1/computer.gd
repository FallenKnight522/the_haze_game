extends the_haze_object

var inter = 1

func interact():
	match inter:
		1:
			SignalManager.show_text.emit("A computer. It does not seem to turn on.")
		2:
			SignalManager.show_text.emit("Maybe if you open the case and check the wires, you could get it working.")
		3:
			SignalManager.fear.emit(5)
			SignalManager.show_text.emit("Why is the case BLEEDING?")
		4:
			SignalManager.show_text.emit("IT CAN TALK??")
			SignalManager.show_text.emit('"The sharp edges hurt my mind. Free mee!"')
			SignalManager.fear.emit(10)
		_:
			SignalManager.show_text.emit("Not touching that again")
			inter -=1
	inter +=1
			
