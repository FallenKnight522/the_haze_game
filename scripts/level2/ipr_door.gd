extends the_haze_object
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collider: CollisionShape2D = $Collider/CollisionShape2D
var opened = false
var spiraldoor = false
var player_inside = false
var closed = false
@onready var cap_pos: Marker2D = $Cap_pos
@onready var statue_pos: Marker2D = $Statue_pos
@onready var statue_pos_2: Marker2D = $Statue_pos2

# Called when the node enters the scene tree for the first time.
func interact():
	if player_inside:
		return
	if closed && !opened:
		SignalManager.show_text.emit("This door appears to be locked")
		return
	opened = !opened 
	if(!opened):
		collider.set_deferred("disabled", opened) # player is guarnateed not to stand in the way
		animated_sprite_2d.play("close")
	else:
		animated_sprite_2d.play("open")
		await animated_sprite_2d.animation_finished
		collider.set_deferred("disabled", opened)
		


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		can_interact = false
		hide_hint()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		can_interact = true
		show_hint()


func _on_door_entered(body: Node2D) -> void:
	if body.is_in_group("player") && spiraldoor:
		get_tree().call_deferred("change_scene_to_file","res://scenes/rooms/Endless_hall.tscn")
	
func reset():
	if opened:
		interact()
	spiraldoor = false
	player_inside = false
	closed = false
