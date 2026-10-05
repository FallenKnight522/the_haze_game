extends Node2D
class_name Object_manager

@export var DialogName: String
@onready var dialog: DialogueResource = load("res://dialog/" + DialogName)
var day = 0
signal new_day(day: int)

const s_lonely0 = "[color=#77777788]"
const e_lonely0 = "[/color]"
const s_lonely1 = "[color=#77777788]"
const e_lonely1 = "[/color]"
const s_lonely2 = "[color=#AAAAAA88]"
const e_lonely2 = "[/color]"
const s_lonely3 = "[b]"
const e_lonely3 = "[/b]"
var s_lonely4 = "[color=#AAAAAA88] [fade start=5 length=5]"
const e_lonely4 = "[/fade] [/color]"

func text_len(leng):
	s_lonely4 = "[color=#AAAAAA88] [fade start=5 length=" + str(leng) + "]"



func interaction(_name: String, _interaction: int, _caller: the_haze_object2 = null):
	pass
func end_conversation():
	pass
func show_prop(prop:int):
	pass
