extends the_haze_object
var poslist: Array[Marker2D] = []
var interraction = 0
var file = false
# Called when the node enters the scene tree for the first time.
func interact():
	if(interraction == 0):
		SignalManager.show_text.emit("What a strange statue... Where did it go?")
		SignalManager.show_text.emit("Where have I seen it before?")
	interraction+=1
	move_self() 
func move_self():
	if poslist.is_empty():
		return
	poslist.shuffle()
	global_position = poslist[0].global_position
