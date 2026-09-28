extends StaticBody2D

@onready var npc_data : NPC
var npc_name : String

@onready var sprite := $sprite
@onready var hitbox := $InteractableHitboxComponent

func _ready() -> void:
	npc_name = npc_data.name
	sprite.texture = npc_data.texture #preload("res://assets/world/rpg/foliage/rock_pilgrim16.png")
	hitbox.key_pressed.connect(interact)

func interact():
	if !hitbox.is_overlapping:
		return
	print("talk!")
