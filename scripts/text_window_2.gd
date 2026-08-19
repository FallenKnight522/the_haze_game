extends CanvasLayer

@onready var textbox_container: MarginContainer = $TextboxContainer
var tw: Tween
@onready var rich_text_label: RichTextLabel = $TextboxContainer/PanelContainer/RichTextLabel
const speed = 0.05
signal text_finished
signal text_started
signal window_finished(text: String)##either context or the text displayed, so we know what window finished
#if forced text is disabled, will be sent when new forced request is rejected
enum state{
	READY,
	READING,
	FINISHED,
	CHOOSING2
}
var current_state = state.READY
var text_queue = []
var choice_queue = []
var action_queue = []
var choice_first = true
var force_enabled = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_state = state.READY

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	match current_state:
		state.READY:
			if(!text_queue.is_empty()):
				hadle_text()
			else:
				hide_textbox()
		state.READING:
			if(Input.is_action_just_pressed("escape")):
				rich_text_label.visible_ratio = 1.0
				tw.kill()
				change_state(state.FINISHED)
		state.FINISHED:
			if(Input.is_action_just_pressed("escape")):
				window_finished.emit(rich_text_label.text)
				change_state(state.READY)
		state.CHOOSING2:
			if(Input.is_action_just_pressed("escape")):
				window_finished.emit(text_queue.pop_front())
				choice_queue.pop_front()
				choice_queue.pop_front()
				if(choice_first):
					var act = action_queue.pop_front()
					if act.is_valid():
						act.call()
				else:
					action_queue.pop_front()
					var act = action_queue.pop_front()
					if act.is_valid():
						act.call()
				change_state(state.READY)
			elif(Input.is_action_just_pressed("move left")):
				choice_first = true	
				rich_text_label.text = text_queue[0]+ "\n* "+ choice_queue[0]+ "			  " + choice_queue[1]
			elif(Input.is_action_just_pressed("move right")):
				choice_first = false	
				rich_text_label.text = text_queue[0]+ "\n  "+ choice_queue[0]+ "			" + "* "+choice_queue[1]

func hide_textbox():
	text_finished.emit()
	rich_text_label.text = ""
	textbox_container.hide()

func show_textbox():
	text_started.emit()
	textbox_container.show()
func queue_text(next_text):
	text_queue.push_back(next_text)
	
func queue_choice2(context: String, choice1:String, choice2: String, action1: Callable= Callable(), action2: Callable = Callable()):
	text_queue.push_back("/Choice 2/") #Special text signaling there is choice between 2 argument waitnig
	text_queue.push_back(context)
	choice_queue.push_back(choice1)
	choice_queue.push_back(choice2)
	action_queue.push_back(action1)
	action_queue.push_back(action2)
	

func hadle_text():
	var text = text_queue.pop_front()
	if(text == "/Choice 2/"):
		display_choice2()
	else:
		display_text(text)
func display_text(text):
	rich_text_label.text = text
	change_state(state.READING)
	show_textbox()
	if tw and tw.is_running():
		tw.kill()
	rich_text_label.visible_ratio =0.0
	tw = create_tween()
	var doba = rich_text_label.get_parsed_text().length() * speed
	tw.tween_property(rich_text_label, "visible_ratio", 1.0, doba)
	tw.finished.connect(_on_text_finished)
func display_choice2():
	rich_text_label.text = text_queue[0]+ "\n* "+ choice_queue[0]+ "			  " + choice_queue[1]
	change_state(state.CHOOSING2)
	choice_first = true
	show_textbox()

func _on_text_finished():
	change_state(state.FINISHED)
func change_state(_state):
	current_state = _state

func force_text(text: String):
	if(!force_enabled):
		window_finished.emit(text)		
		return
	match current_state:
		state.READING:
			rich_text_label.visible_ratio = 1.0
			tw.kill()
			text_queue.push_front(rich_text_label.text)
		state.FINISHED:
			text_queue.push_front(rich_text_label.text)
		state.CHOOSING2:
			text_queue.push_front("/Choice 2/")
	#Order is switched since I push to front now
	text_queue.push_front(text) 
	change_state(state.READY)

func force_choice2(context: String, choice1:String, choice2: String, action1: Callable= Callable(), action2: Callable = Callable()):
	if(!force_enabled):
		window_finished.emit(context)
		return
	match current_state:
		state.READING:
			rich_text_label.visible_ratio = 1.0
			tw.kill()
			text_queue.push_front(rich_text_label.text)
		state.FINISHED:
			text_queue.push_front(rich_text_label.text)
		state.CHOOSING2:
			text_queue.push_front("/Choice 2/")
	#Order is switched since I push to front now
	text_queue.push_front(context) 
	text_queue.push_front("/Choice 2/") #Special text signaling there is choice between 2 argument waitnig
	choice_queue.push_front(choice2)
	choice_queue.push_front(choice1)
	action_queue.push_front(action2)
	action_queue.push_front(action1)
	change_state(state.READY)
	
	
