extends AnimatedSprite2D
var blinking = false
var time = randf_range(4,10)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time-= delta
	if time <= 0 and not blinking:
		blink()
		time = randf_range(4,10)
func blink():
	blinking = true
	play("blink")
	await animation_finished
	blinking = false
