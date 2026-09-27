extends Node

var inside_house : bool = false # incase the player decides to explore a place
var carrying_item : bool = false # for carrying statues..etc for puzzles and all
var pos : Vector2 = Vector2.ZERO #keeps track of player position
var debuffs : Dictionary[String, bool] = {} #debuff name and active or not

#platformer
var is_hurt : bool = false
