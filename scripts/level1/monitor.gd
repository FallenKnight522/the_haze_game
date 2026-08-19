extends the_haze_object

var first = false

func interact():
	if !first:
		SignalManager.show_text.emit("A computer monitor. But it does not seems like I can turn it on.")
		first = true
	else:
		SignalManager.show_text.emit("Why is it comming closer?")
		SignalManager.fear.emit(5)

			
