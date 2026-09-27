extends Control

@onready var positon_label := $VBoxContainer/player_pos
@onready var cam_label := $VBoxContainer/cam_pos
@onready var player := $".."
@onready var player_cam := $"../../player_cam"
 
func _ready() -> void:
	add_to_group("debug_menu")

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	positon_label.text = "player pos: " + str(player.position)
	cam_label.text = "cam pos: " + str(player_cam.position) # + Vector2(272,160))
