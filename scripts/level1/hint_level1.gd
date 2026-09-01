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
			text = "Once the bar is full, you may leave. Interacting with the weirdness here will frighten you soon."
		5:
			text = "There are no more hints"
		6:
			text = "Once the bar is full, you may leave. Interacting with the weirdness here will frighten you soon."
		7:
			text = "Truly, there are no more hints here. No need to keep trying."
		10:
			text = "I was being serious. You will not achieve anything by spamming this button"
		11:
			text = "Give up, honestly. Just stop it"
		15:
			text = "You really are stubborn"
		25:
			text = "I really want to ignore you, but I feel bad... Please, give up before I feel even worse"
		49:
			text = "All right, you know what. One more, and I will give you something"
		50:
			text = "If you promise not to spam this anymore, ok? Look into the Download file"
			SignalManager.download_file.emit("technical.zip")
		51:
			text = "That's it. I have nothing more. You promised, so keep that promise"	
			hintNum = 50
		_:
			text = "There are no more hints"
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
