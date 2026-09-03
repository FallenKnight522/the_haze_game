extends the_haze_object

var interaction = 0
func interact():
	match interaction:
		0:
			SignalManager.show_text.emit("Is that cup levitating?")
		1:
			SignalManager.show_text.emit("It looks like it ignores the gravity completely")
		2:
			SignalManager.show_text.emit("Why does it look familliar to me..")
			interaction-= 1
	interaction+= 1
