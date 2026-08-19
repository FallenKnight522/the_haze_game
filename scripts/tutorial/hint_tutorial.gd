extends hint
@onready var text_window: CanvasLayer = %Text_window
var currText = ""; #Text currently sent to be last, before the icon changes

func showHint():
	currText = "The goal here is learn what to do in this game"
	text_window.force_text(currText)
func windowLeft(text: String):
	if(currText == text):
		hideHint()
