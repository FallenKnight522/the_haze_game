extends the_haze_object

var interaction = 0
func interact():
	match interaction:
		0:
			SignalManager.show_text.emit("Is that cup levitating?")
			SignalManager.fear.emit(1)
		1:
			SignalManager.show_text.emit("It looks like it ignores the gravity here")
			SignalManager.fear.emit(1)
		2:
			SignalManager.show_text.emit("Not just here, all gravity. It should spill, but the drink remains..")
			SignalManager.fear.emit(1)
		3:
			SignalManager.show_text.emit("Maybe, if I time it right, I can taste what's inside..")
			SignalManager.fear.emit(1)
		4:
			SignalManager.show_choice2.emit("Drink from it?", "Yes", "No", drink)
		5:
			SignalManager.download_file.emit("0x49.txt")
		_:
			SignalManager.show_text.emit("Better leave it alone")
			interaction-=1
	interaction+= 1
func drink():
		SignalManager.show_text.emit("Tastes like milk... with something in it")
		SignalManager.show_text.emit("Is that a tooth in it???")
		SignalManager.show_text.emit("And there is more in the cup!!!")
		SignalManager.show_text.emit("What... how... I rather not know")
		SignalManager.fear.emit(10)
	
