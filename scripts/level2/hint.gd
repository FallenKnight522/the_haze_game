extends hint
@onready var text_window: CanvasLayer = %Text_window
var currText = ""; #Text currently sent to be last, before the icon changes
var hintNum = 0

func showHint():
	var text
	match hintNum:
		0:
			text = "Find a way to get more information about that house."
		1:
			text = "The institute has a powerfull artefact, whitch just might help you"
		2:
			text = "You need to please the Eye, to get answers. Try reading statements"
		3:
			text = "Unlock objects and use them to obtain statements. Once you have enought fear, you will get answers"
		4:
			text = "This level is like an escape room. Solve puzzles, get statements, increse your fear. Once it overflows, the Eye will answer"
		5:
			text = "There are no more hints"
		6:
			text = "This level is like an escape room. Solve puzzles, get statements, increse your fear. Once it overflows, the Eye will answer"
		_:
			text = "There are no more hints"
			hintNum = 5
			
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
