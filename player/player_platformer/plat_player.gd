extends CharacterBody2D

@export var speed : float = 150
var dir
@export var jump_vel : float = 300

@export_range(0.0,2.0) var max_accn : float = 0.9
@export var accn_curve : Curve
var accn : float = 0.0
@export_range(0.0, 1.0) var deccn : float = 0.75

@export var is_hurt : bool = false

func _ready() -> void:
	max_accn *= 1000
	deccn *= 1000
	add_to_group("player_plat")

func _process(delta: float) -> void:
	if not is_on_floor():
		if velocity.y > -20:
			velocity += get_gravity() * delta * 1.25 
		else:
			velocity += get_gravity() * delta

	if is_on_floor() and Input.is_action_pressed("up"):
		velocity.y -= 300

	dir = Input.get_axis("left", "right")
	if dir:
		#samples current_accn/max_accn to generte values between 0 and 1
		if velocity.x < 0 && dir > 0: velocity.x = -5
		if velocity.x > 0 && dir < 0: velocity.x = 5
		velocity.x = move_toward(velocity.x, speed * dir, max_accn * accn_curve.sample(accn/max_accn) * delta)
		accn += clamp(100, 0, max_accn)
		
		$Sprite2D.flip_h = not bool(dir + 1)
	else:
		velocity.x = move_toward(velocity.x, 0, deccn * delta)
		accn = 0

	move_and_slide()
