extends  Node2D

# all of the elevations
@onready var elevation_scenes : Array[PackedScene] = [
	preload("res://worlds/elevation_1.tscn"),
	preload("res://worlds/elevation_2.tscn")
]
# all npc (there aren't that many so its fine
@onready var npc_types : Array[NPC] = [
	preload("res://NPC/npcs/NPC1.tres"),
	preload("res://NPC/npcs/NPC2.tres")
]
@onready var npc_world = preload("res://NPC/npc_world.tscn")
#for puzzle statues
@onready var puzzle_statue = preload("res://misc_/components/puzzle_statues.tscn")

#stores current elevation scene
var elevation
# stores current elevation number
var elevation_num : int = 1

var base_elevation
var cam_bounds

func _ready() -> void: 
	print(
		(str_to_var("Vector2" + "1(10,5)".substr(1)) as Vector2) * 0.5
		)
	# load the first elevation when the game is loaded
	call_deferred("change_elevation_to", elevation_num)
	
func change_elevation_to(id: int):
	if id > elevation_scenes.size() || id < 0: return
	
	if get_child_count() != 0:
		for i in get_children():
			if i is StaticBody2D: self.remove_child(i)
		self.remove_child(
			get_children()[0] # remove previous elevation
		)
		
	
	elevation = elevation_scenes[elevation_num - 1].instantiate()
	elevation.global_position = position
	
	add_child.call_deferred(elevation)
	
	#find camera range tiles and set camera bounds
	base_elevation = elevation.get_child(0)
	cam_bounds = base_elevation.get_used_cells_by_id(-1, Vector2i(0,0))
	
	for i in len(cam_bounds):
		cam_bounds[i] = base_elevation.map_to_local(cam_bounds[i])
	
	# place interactables <!>
	# first get number of children, then pick the last child
	
	base_elevation = elevation.get_child(
		elevation.get_child_count(false) - 1
	)
	var positions
	if base_elevation:
		positions = base_elevation.get_used_cells_by_id(0, Vector2i(1,1))
	
	for i in positions:
		var statue = puzzle_statue.instantiate()
		statue.position = base_elevation.map_to_local(i)
		self.add_child.call_deferred(statue)
	print(positions)
	
	
	# place npcs <!>
	var _npc
	for i in range(len(npc_types)):
		if len(base_elevation.get_used_cells_by_id(0, Vector2i(i,0))) == 0: continue
		
		_npc = npc_world.instantiate()
		
		_npc.position = base_elevation.map_to_local(
			base_elevation.get_used_cells_by_id(0, Vector2i(i,0))[0]
		)
		_npc.npc_data = npc_types[i]
		
		self.add_child.call_deferred(_npc)
		#====================================#
		# tilemap consists of a row of tiles which are meant to indicate positons of npcs
		# all of them are to be made in a single row
		# this iterates over the row and checks if the tile is present or not
		#====================================#
		
	SignalBus.set_camera_bounds.emit(cam_bounds)
	
func _on_scene_change_body_entered(body: Node2D) -> void:
	if !body || Transition.ongoing: return
	if !body.is_in_group("player"): return
	
	%player_rpg.position.y -= 32
	elevation_num += 1
	
	Transition.transition()
	change_elevation_to(elevation_num)

func _on_scene_down_body_entered(body: Node2D) -> void:
	if !body || Transition.ongoing: return
	if !body.is_in_group("player"): return
	
	%player_rpg.position.y += 32 
	elevation_num -= 1
	
	Transition.transition()
	change_elevation_to(elevation_num)
