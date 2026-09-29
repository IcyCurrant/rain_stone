extends StaticBody2D

var picked_up : bool = false
@onready var hitbox := $InteractableHitboxComponent

func _ready() -> void:
	hitbox.key_pressed.connect(interact)

func interact():
	if PlayerDat.carrying and picked_up:
		position = PlayerDat.pos
		collision_layer = 1
		visible = true
		
		picked_up = false
		PlayerDat.carrying = false
	if !hitbox.is_overlapping:
		return
	if PlayerDat.carrying:
		return
	
	collision_layer = 100
	visible = false
	
	picked_up = true
	PlayerDat.carrying = true
