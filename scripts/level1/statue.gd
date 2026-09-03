extends the_haze_object
@export var poslist: Array[Marker2D] = []
var interraction = 0
var file = false
# Called when the node enters the scene tree for the first time.
func interact():
	if poslist.is_empty():
		return
	if(interraction == 0):
		SignalManager.show_text.emit("What a strange stat... ue... Where did it go?")
	elif(interraction == 5 && !file):
		SignalManager.download_file.emit("0x79.txt")
	poslist.shuffle()
	global_position = poslist[0].global_position
	interraction+=1 
