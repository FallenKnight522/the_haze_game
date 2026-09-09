extends Node

var text_full_on = [ false , false , false , false ]
var text_showing = false

signal fear(val: int)
signal fear_limit()
signal fear_changed(val: int)
signal show_text(text: String)
signal show_input(text: String)
signal input_recieved(text: String, responce: String)
signal show_choice2(context: String, choice1: String, choice2: String, act1: Callable, act2: Callable)
signal change_room(id_mistnosti: String, cesta_k_scene: String)
signal show_dialog(dialog: DialogueResource, text: String)
signal move_player(pos: Vector2)
signal download_file(file: String)
