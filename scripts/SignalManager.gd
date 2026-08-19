extends Node


signal fear(val: int)
signal fear_limit()
signal fear_changed(val: int)
signal show_text(text: String)
signal show_choice2(context: String, choice1: String, choice2: String, act1: Callable, act2: Callable)
signal change_room(id_mistnosti: String, cesta_k_scene: String)
