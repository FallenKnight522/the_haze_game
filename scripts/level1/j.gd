extends the_haze_object
var time = 0
var maxtime = 10
@onready var animate: AnimatedSprite2D = $AnimatedSprite2D
var dialog: DialogueResource = load("res://dialog/J.dialogue")
var interaction = 0
func _ready() -> void:
	hide_hint() # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time+=delta
	if time > maxtime:
		time = 0
		show_animatic()
func show_animatic():
	var animatic = randi_range(0,20)
	match animatic:
		1:
			animate.play("idle1")
			SignalManager.fear.emit(1)
		2:
			SignalManager.fear.emit(1)
			animate.play("idle1_2")
		3:
			SignalManager.fear.emit(1)
			animate.play("idle1_3")
		4:
			SignalManager.fear.emit(1)
			animate.play("idle1_4")
		5:
			SignalManager.fear.emit(1)
			animate.play("idle1_5")
		6:
			SignalManager.fear.emit(1)
			animate.play("idle1_6")
		7:
			SignalManager.fear.emit(1)
			animate.play("idle1_7")
		8:
			SignalManager.fear.emit(1)
			animate.play("idle1_8")
		9:
			SignalManager.fear.emit(1)
			animate.play("idle1_9")
		13:
			SignalManager.fear.emit(1)
			animate.play("idle1_3")
		14:
			SignalManager.fear.emit(1)
			animate.play("idle1_4")
		15:
			SignalManager.fear.emit(1)
			animate.play("idle1_5")
		16:
			SignalManager.fear.emit(1)
			animate.play("idle1_6")
		17:
			SignalManager.fear.emit(1)
			animate.play("idle1_7")
		_:
			animate.play("idle")
func interact():
	match interaction:
		0:
			if dialog != null:
				SignalManager.show_dialog.emit(dialog)
			else:
				push_error("Dialogue resource se nepodařilo načíst!")
			interaction+=1
		1:
			if dialog != null:
				SignalManager.show_dialog.emit(dialog, "start2")
			else:
				push_error("Dialogue resource se nepodařilo načíst!")
			interaction+=1
		2:
			SignalManager.show_text.emit("(Něco je s tím člověkem špatně. Nevím co přesně, ale přísahal bych že on i ten stůl před chvílí vypadal jinak)")
			SignalManager.show_text.emit("(Měl bych jít, musím najít ostatní)")
