extends StaticBody2D

var picked_up : bool = false
@onready var hitbox := $InteractableHitboxComponent

func _ready() -> void:
	hitbox.key_pressed.connect(interact)

func interact():
	if picked_up:
		position = PlayerDat.pos
		visible = true
		picked_up = false
	
	if !hitbox.is_overlapping:
		return
	
	visible = false
	picked_up = true
