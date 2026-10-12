extends hint
@onready var text_window: CanvasLayer = %Text_window
var currText = ""; #Text currently sent to be last, before the icon changes
var hintNum = 0

func showHint():
	var text
	match hintNum:
		0:
			text = "Just finish the third level of your game, and all will be okay."
		1:
			text = "Try distracting yourself from the loneliness."
		2:
			text = "There are many things in your room that can calm you down. Find which to use when."
		3:
			text = "The items in the room lower your fear. Working on the game progresses you further, but triggers lonely memories. Balance the two."
		4:
			text = "As time goes on, some items stop working. Same with items used too often."
		5:
			text = "Pick correctly what item to use when, to endure till the end."
		_:
			text = "There are no more hints. Maybe ask one of your friends for... oh that's right... you don't have any left."
			SignalManager.fear.emit(10)
	if hintNum < 5:
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
