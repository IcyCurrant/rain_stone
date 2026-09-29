extends StaticBody2D
   
@onready var npc_data : NPC
var npc_name : String

var dialogues : Array #stores dialogues from json file [String]

@onready var sprite := $sprite
@onready var hitbox := $InteractableHitboxComponent

func _ready() -> void:
	npc_name = npc_data.name
	sprite.texture = npc_data.texture #preload("res://assets/world/rpg/foliage/rock_pilgrim16.png")
	
	hitbox.key_pressed.connect(interact)

func interact():
	if !hitbox.is_overlapping:
		return
	print(get_dialogues())

func get_dialogues() -> Array:
	var parsed_data := load_json("res://NPC/dialgoues.json")
	if !parsed_data: return []
	
	dialogues = parsed_data.get(npc_name, [])
	return dialogues

func load_json(path : String) -> Dictionary:
	if !FileAccess.file_exists(path):
		printerr("invalid path")
		return {}
	
	var file = FileAccess.open(path,FileAccess.READ)
	
	if !file:
		printerr("invalid file")
		return {}	
	
	var dialogue_file = file.get_as_text()
	file.close()
	dialogue_file = JSON.parse_string(dialogue_file)
	return dialogue_file
