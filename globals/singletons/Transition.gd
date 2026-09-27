extends CanvasLayer

@onready var panel := $ColorRect
@onready var anim := $AnimationPlayer

signal on_transition_finished

var ongoing : bool = false

func _ready() -> void:
	panel.visible = false

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "to_black":
		anim.play("from_black")
		ongoing = false
		on_transition_finished.emit()
	elif anim_name == "from_black":
		panel.visible = false

func transition():
	ongoing = true
	panel.visible = true
	anim.play("to_black")
