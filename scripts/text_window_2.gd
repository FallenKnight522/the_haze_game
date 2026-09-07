extends CanvasLayer
@onready var line_edit: LineEdit = $TextboxContainer/PanelContainer/MarginContainer/LineEdit
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
	CHOOSING2,
	CHOOSING,
	INPUT
}
var current_state = state.READY
var text_queue = []
var choice_queue = []
var action_queue = []
var choice = 0
var force_enabled = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_state = state.READY
	line_edit.hide()
func clear():
	text_queue.clear()
	choice_queue.clear()
	action_queue.clear()
	choice = 0
	force_enabled = true
	current_state = state.READY
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	match current_state:
		state.READY:
			if(!text_queue.is_empty()):
				handle_text()
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
				change_state(state.READY)
				window_finished.emit(text_queue.pop_front())
				choice_queue.pop_front()
				if(choice < 0 || choice > 1):
					push_error("Invalid choice")
					return
				var act = action_queue.pop_front()
				if act[choice].is_valid():
						act[choice].call()
			elif(Input.is_action_just_pressed("move left")):
				choice = 0	
				rich_text_label.text = text_queue[0]+ "\n* "+ choice_queue.front()[0]+ "			  " + choice_queue.front()[1]
			elif(Input.is_action_just_pressed("move right")):
				choice = 1	
				rich_text_label.text = text_queue[0]+ "\n  "+ choice_queue.front()[0]+ "			" + "* "+choice_queue.front()[1]
		state.CHOOSING:
			if(Input.is_action_just_pressed("escape")):
				change_state(state.READY)
				window_finished.emit(text_queue.pop_front())
				choice_queue.pop_front()
				var act = action_queue.pop_front()
				if act[choice].is_valid():
						act[choice].call()
			elif(Input.is_action_just_pressed("move left")):
				if choice - 1 < 0:
					choice = choice_queue.front().size()
				choice = choice - 1	
				rich_text_label.text = text_queue[0]+ "\n<- 		"+ choice_queue.front()[choice]+ "		->"
			elif(Input.is_action_just_pressed("move right")):
				if choice + 1 >= choice_queue.front().size():
					choice = -1	
				choice = choice + 1	
				rich_text_label.text = text_queue[0]+ "\n<- 		"+ choice_queue.front()[choice]+ "		->"
		state.INPUT:
			pass
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
	var choices = []
	choices.push_back(choice1)
	choices.push_back(choice2)
	choice_queue.push_back(choices)
	var actions = []
	actions.push_back(action1)
	actions.push_back(action2)
	action_queue.push_back(actions)

func queue_choice(context: String, choices: Array[String], actions: Array[Callable]= []):
	text_queue.push_back("/Choice X/") #Special text signaling there is choice between 2 argument waitnig
	text_queue.push_back(context)
	if choices.size() < actions.size():
		push_error("More actions than choices")
	while choices.size() > actions.size():
		actions.push_back(Callable())
	choice_queue.push_back(choices)
	action_queue.push_back(actions)	
func queue_input(context: String):
	text_queue.push_back("/Input/") #Special text signaling there is choice between 2 argument waitnig
	text_queue.push_back(context)

func handle_text():
	var text = text_queue.pop_front()
	if(text == "/Choice 2/"):
		display_choice2()
	elif(text == "/Choice X/"):
		display_choice()
	elif(text == "/Input/"):
		read_input()
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
func display_choice():
	if(choice_queue.is_empty() || text_queue.is_empty()):
		printerr("Chybí argumenty")
	rich_text_label.text = text_queue[0]+ "\n<- 		"+ choice_queue.front()[0]+ "		->"
	change_state(state.CHOOSING)
	choice = 0
	show_textbox()
func display_choice2():
	if(choice_queue.is_empty() || text_queue.is_empty()):
		printerr("Chybí argumenty")
	rich_text_label.text = text_queue[0]+ "\n* "+ choice_queue.front()[0]+ "			  " + choice_queue.front()[1]
	change_state(state.CHOOSING2)
	choice = 0
	show_textbox()
func read_input():
	if(text_queue.is_empty()):
		printerr("Chybí argumenty")
	rich_text_label.text = text_queue[0]
	line_edit.show()
	change_state(state.INPUT)
	line_edit.grab_focus()
	line_edit.clear()

func _on_line_edit_text_submitted(new_text: String) -> void:
	line_edit.hide()
	line_edit.clear()
	line_edit.release_focus()
	if(text_queue.is_empty()):
		printerr("Chybí argumenty")
	SignalManager.input_recieved.emit(text_queue.pop_front(), new_text)
	change_state(state.READY)
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
		state.CHOOSING:
			text_queue.push_front("/Choice X/")
		state.INPUT:
			text_queue.push_front("/Input/")
			line_edit.clear()
			line_edit.release_focus()
			line_edit.hide()
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
		state.CHOOSING:
			text_queue.push_front("/Choice X/")
		state.INPUT:
			text_queue.push_front("/Input/")
			line_edit.clear()
			line_edit.release_focus()
			line_edit.hide()
	#Order is switched since I push to front now
	text_queue.push_front(context) 
	text_queue.push_front("/Choice 2/") #Special text signaling there is choice between 2 argument waitnig
	var choices = []
	choices.push_back(choice1)
	choices.push_back(choice2)
	choice_queue.push_front(choices)
	var actions = []
	actions.push_back(action1)
	actions.push_back(action2)
	action_queue.push_front(actions)
	change_state(state.READY)

func queue_dialog(dialogue_resource: DialogueResource, line_id: String = "start", node: Node = self):
	#Made with Spider.LLM
	# 1. Vytáhneme datový objekt z Dialogue Manageru
	var line: DialogueLine = await DialogueManager.get_next_dialogue_line(dialogue_resource, line_id,[node])
	
	# Pokud je řádek null, konverzace skončila
	if line == null:
		return

	var ended_text = ""
	# 2. Rozhodneme, zda jde o volbu nebo běžný text
	if line.responses.size() > 0 && line.responses.size() <= 2:
		# Sestavíme text kontextu (např. "Pavouk: Co uděláš?")
		var kontext := (line.character + ": " if line.character else "") + line.text
		
		# Vytáhneme texty pro 2 volby
		var volba1_text: String = line.responses[0].text
		var volba2_text: String = line.responses[1].text if line.responses.size() > 1 else ""

		# Vytvoříme anonymní funkce (Callable) pro předání akci
		var akce1 := func(): queue_dialog(dialogue_resource,line.responses[0].next_id, node)
		var akce2 := func(): 
			if line.responses.size() > 1:
				queue_dialog(dialogue_resource,line.responses[1].next_id, node)

		# Zavoláme tvoji funkci na UI
		queue_choice2(kontext, volba1_text, volba2_text, akce1, akce2)
	elif line.responses.size() > 0 :
		# Sestavíme text kontextu (např. "Pavouk: Co uděláš?")
		var kontext := (line.character + ": " if line.character else "") + line.text
		var text: Array[String] = []
		var choices: Array[Callable] = []
		# Vytáhneme texty pro 2 volby
		for i in range(line.responses.size()):
			text.push_back(line.responses[i].text)
			choices.push_back(func(): queue_dialog(dialogue_resource,line.responses[i].next_id, node))
		queue_choice(kontext, text, choices)	
	else:
		# Běžný text
		var plny_text := (line.character + ": " if line.character else "") + line.text
		queue_text(plny_text)
		while ended_text != plny_text:
			ended_text = await window_finished
		
		queue_dialog(dialogue_resource,line.next_id, node)
		
