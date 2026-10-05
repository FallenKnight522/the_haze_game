extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("RESET")
	
	await get_tree().create_timer(2).timeout
	play("begining")
	await get_tree().create_timer(2).timeout
	play("policeman_leaves")
	await get_tree().create_timer(2).timeout
	play("mom_leaves")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("leave")): 
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
