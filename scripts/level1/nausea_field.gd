extends Area2D

@onready var color_rect: ColorRect = $"../../CanvasLayer/ColorRect"
static var nausea = 0
const nausea_to_fear_mod = 5
const nausea_to_dizzy = 10
var id =0
func _ready() -> void:
	nausea = 0
	id = get_instance_id()
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("invert_move"):
		if body.invert_move(id):
			if color_rect.material is ShaderMaterial:
				color_rect.material.set_shader_parameter("is_inverted", !color_rect.material.get_shader_parameter("is_inverted"))
			if body.is_in_group("player"):
				nausea+=1
				if(nausea%nausea_to_fear_mod == 0):
					SignalManager.fear.emit(nausea/nausea_to_fear_mod)
				match nausea:
					1:
						SignalManager.show_text.emit("Hold on, WHAT? Where am I going")
					5:
						SignalManager.show_text.emit("No wait, somethings terribly wrong... Where... where am I going")
					30:
						SignalManager.show_text.emit("[Sharp Inhale] I... [Sharp Exhale] I need..[Sharp Inhale] I must get out ...")
					50:
						SignalManager.show_text.emit("What is this madness")
				if nausea%nausea_to_dizzy == 0:
					color_rect.material.set_shader_parameter("dizziness_intensity", nausea/nausea_to_dizzy*0.01)
					print("Dizzyness " + str(nausea/nausea_to_dizzy*0.01))
