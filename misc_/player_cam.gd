extends Camera2D

@onready var player := $"../player_rpg"

func _ready() -> void:
	SignalBus.set_camera_bounds.connect(set_bounds)
	add_to_group("camera")

func _process(_delta: float) -> void:
	position = lerp(position, player.position, 0.5)

func set_bounds(pos: Array):
	pos.sort()
	limit_left = pos[0].x + 32
	limit_right = pos[3].x - 32
	
	limit_top = pos[1].y + 32
	limit_bottom = pos[2].y - 32
