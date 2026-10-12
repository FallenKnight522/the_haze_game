extends Object_manager
@onready var level_3: Node2D = $".."
var flags = {}
const memories = ["interogation", "sister", "messages", "to_Prague", "BirthdayParty", "Cold", "HappierTimes"]
@onready var police_station: AnimationPlayer = $Props/police_station
@onready var jouline_interraction: AnimationPlayer = $Props/jouline_interraction
@onready var phone: Sprite2D = $Props/phone
@onready var to_prague: AnimationPlayer = $Props/toPrague
@onready var birthday: AnimationPlayer = $Props/birthday
@onready var props: Node2D = $Props
@onready var cloud: Sprite2D = $Props/cloud
@onready var cloud_2: Sprite2D = $Props/cloud2
@onready var fear: CanvasLayer = %Fear





func interaction(_name: String, _interaction: int, _caller: the_haze_object2 = null):
	if dialog != null:
		match _name:
			"default":
				pass
			"test":
				SignalManager.fear.emit(10)
			_:
				SignalManager.show_dialog.emit(dialog, _name + str(_interaction), self)
	else:
			push_error("Dialog not loaded")
	
	
func end_conversation():
	SignalManager.change_room.emit("room")	
	await reset_props()
	props.process_mode = Node.PROCESS_MODE_DISABLED
func end_day():
	day+=1
	if day >= 8:
		await level_3.loose()
	else:
		await  level_3.fadeout()
		new_day.emit(day)
		props.process_mode = Node.PROCESS_MODE_INHERIT
		SignalManager.change_room.emit("memory")
		interaction(memories[day-1], 0)
func _ready() -> void:
	new_day.emit(day)
	reset_props()
func show_prop(prop: int):
	SignalManager.animatic_showing = true
	SignalManager.move_player.emit()
	match prop:
		0:
			reset_props()
		1:
			level_3.player.turn_right()
			police_station.play("begining")
			await police_station.animation_finished
		2:
			level_3.player.turn_right()
			police_station.play("policeman_leaves")
			await police_station.animation_finished
		3:
			police_station.play("mom_leaves")
			await police_station.animation_finished
			level_3.player.turn_left()
		4:
			level_3.player.turn_left()
			police_station.play("door_shift")
			await police_station.animation_finished
		5:
			level_3.player.turn_left()
			police_station.play("statue_gone")
			await police_station.animation_finished
		6:
			level_3.player.turn_right()
			jouline_interraction.play("begining")
			await jouline_interraction.animation_finished
		7:
			level_3.player.turn_right()
			jouline_interraction.play("jouline_leaves")
			await jouline_interraction.animation_finished
		8:
			phone.show()
			phone.global_position = Vector2(-548,-41)
		9:
			await level_3.fadeout()
			phone.show()
			phone.global_position = Vector2(-157,-47)
			SignalManager.move_player.emit(Vector2(-182,-27))
			await level_3.fadein()
		10:
			level_3.player.turn_left()
			to_prague.play("begining")
			await to_prague.animation_finished
		11:
			level_3.player.turn_left()
			to_prague.play("bus_arrives")
			await to_prague.animation_finished
		12:
			level_3.player.turn_left()
			to_prague.play("way_Back")
			await to_prague.animation_finished
		13:
			level_3.player.turn_left()
			to_prague.play("way_Back_2")
			await to_prague.animation_finished
		14:
			level_3.player.turn_left()
			to_prague.play("bus_back")
			await to_prague.animation_finished
		15:
			level_3.player.turn_left()
			to_prague.play("bus_back_2")
			await to_prague.animation_finished
		16:
			level_3.player.turn_right()
			to_prague.play("blurr")
			await to_prague.animation_finished
		17:
			level_3.player.turn_right()
			SignalManager.move_player.emit(Vector2(-433,-28))
			birthday.play("beginig")
			await birthday.animation_finished
		18:
			level_3.player.turn_right()
			SignalManager.move_player.emit(Vector2(-433,-28))
			birthday.play("lonely_table")
			await birthday.animation_finished
		19:
			level_3.player.turn_right()
			birthday.play("bonfire")
			await birthday.animation_finished
		20:
			level_3.player.turn_right()
			SignalManager.move_player.emit(Vector2(-433,-28))
			birthday.play("lonely_table_2")
			await birthday.animation_finished
		21:
			SignalManager.change_room.emit("in_moment_memory")	
			level_3.player.turn_left()
			cloud.show()
			SignalManager.move_player.emit(Vector2(-133,-28))
		22:
			level_3.player.turn_left()
			cloud.show()
			SignalManager.move_player.emit(Vector2(-133,-28))
			birthday.play("margaret_appears")
			await birthday.animation_finished
		23:
			level_3.player.turn_left()
			cloud.show()
			SignalManager.move_player.emit(Vector2(-133,-28))
			birthday.play("alice_appears")
			await birthday.animation_finished
		24:
			level_3.player.turn_left()
			cloud.show()
			SignalManager.move_player.emit(Vector2(-133,-28))
			birthday.play("dan_appers")
			await birthday.animation_finished
		25:
			level_3.player.turn_left()
			cloud.show()
			SignalManager.move_player.emit(Vector2(-133,-28))
			birthday.play("jouline_appears")
			await birthday.animation_finished
		26:
			level_3.player.turn_left()
			cloud_2.show()
			SignalManager.move_player.emit(Vector2(-133,-28))
			birthday.play("margaret_comforts")
			await birthday.animation_finished
		27:
			level_3.player.turn_left()
			cloud_2.show()
			SignalManager.move_player.emit(Vector2(-133,-28))
			birthday.play("alice_comforts")
			await birthday.animation_finished
		28:
			level_3.player.turn_left()
			cloud_2.show()
			SignalManager.move_player.emit(Vector2(-133,-28))
			birthday.play("dan_comforts")
			await birthday.animation_finished
		29:
			level_3.player.turn_left()
			cloud_2.show()
			SignalManager.move_player.emit(Vector2(-133,-28))
			birthday.play("elonora_comforts")
			await birthday.animation_finished
		30:
			level_3.player.turn_left()
			cloud_2.show()
			cloud.show()
			SignalManager.move_player.emit(Vector2(-133,-28))
		31:
			level_3.player.turn_left()
			cloud_2.show()
			cloud.hide()
			SignalManager.move_player.emit(Vector2(-133,-28))
		32:
			level_3.player.turn_left()
			cloud.hide()
			SignalManager.move_player.emit(Vector2(-133,-28))
		_:
			push_error("Invalid prop")
			return;
	SignalManager.animatic_showing = false
	
func reset_props():
	police_station.play("RESET")
	jouline_interraction.play("RESET")
	phone.hide()
	cloud.hide()
	cloud_2.hide()
	to_prague.play("RESET")
	birthday.play("RESET")
	await police_station.animation_finished
	await jouline_interraction.animation_finished
	await to_prague.animation_finished
	await birthday.animation_finished
	
