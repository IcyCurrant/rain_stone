class_name NPC
extends Resource

@export var name : String
@export var texture : Texture2D
var dialogues : Array[String]

func get_dialogues() -> Array[String]:
	var parsed_data := load_json("res://NPC/dialgoues.json")
	if !parsed_data: return []
	
	dialogues = parsed_data.get("NPC1", [])
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
