extends StaticBody2D

var texture_ : Texture2D
var npc_name : String

@onready var sprite := $sprite
@onready var hitbox := $InteractableHitboxComponent

func _ready() -> void:
	sprite.texture = preload("res://assets/world/rpg/foliage/rock_pilgrim16.png")
	hitbox.key_pressed.connect(interact)

func interact():
	if !hitbox.is_overlapping:
		return
	print("talk!")
