extends hint
@onready var text_window: CanvasLayer = %Text_window
var currText = ""; #Text currently sent to be last, before the icon changes
var hintNum = 0

func showHint():
	var text
	match hintNum:
		0:
			text = "You came here with friends. Where are they?"
		1:
			text = "Search the rooms. The next one is just behind the door."
		2:
			text = "This place won't let you leave, until you are sufficiently frightened"
		3:
			text = "The bar on the side shows how scared you are."
		4:
			text = "Once the bar is full, you may leave. Interacting with the wierdness here will frighten you soon."
		5:
			text = "There are no more hints"
		_:
			text = "Once the bar is full, you may leave. Interacting with the wierdness here will frighten you soon."
			hintNum = 6
		
	if hintNum < 5:
		print("Make choice")
		currText = "Need more hints?"
		text_window.force_choice2(currText, "Yes", "No", moreHints)
	else:
		currText = text
	text_window.force_text(text)
	hintNum+=1
	
func windowLeft(text: String):
	if(currText == text):
		hideHint()
func moreHints():
	showHint()
