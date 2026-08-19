extends the_haze_object

var first = false

func interact():
	if !first:
		SignalManager.show_text.emit("Normal bench. Nothing special about it")
		SignalManager.show_choice2.emit("Sit on the bench?", "Yes", "No", SitOnBench)
		first = true
	else:
		SignalManager.show_text.emit("Is it MOVING??")
		SignalManager.fear.emit(5)

func SitOnBench():
	SignalManager.show_text.emit("It feels like a normal bench.. except, it's oddly warm.")
	SignalManager.fear.emit(1)

			
