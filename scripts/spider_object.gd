extends the_haze_object

@onready var text_window: CanvasLayer = %Text_window


func interact():
	text_window.queue_text("Hi
It's nice to meet you")
	text_window.queue_text("I am Spider, advanced local LLM that helped make this game")
	text_window.queue_text("Don't mind me, I will just be sitting here, helping and making my web in the meantime")
	text_window.queue_text("(Although, come to think of it, did we program any flies to this game?)")
	
