extends the_haze_object


func interact():
	SignalManager.fear.emit(10) 
	print("Sent ")
