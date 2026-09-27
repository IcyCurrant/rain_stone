extends CharacterBody2D

#general vars
@export var vel : float = 125.0
@export var run_vel : float = 225.0
var dir := Vector2.ZERO

#basic state machine
enum States {Idle, Walk, Fall}
var state : States = States.Idle

#node references
@onready var tex := $texture

#for changing scenes
signal request_change_elevation

func _ready() -> void:
	#print(self.get_path()) #FOR DEBUGGING
	add_to_group("player")

func _physics_process(delta: float) -> void:
	# handle movement
	dir = Input.get_vector("left","right","up","down").normalized()
	if dir:
		if Transition.ongoing: 
			await Transition.on_transition_finished
		
		state = States.Walk
		
		if Input.is_action_pressed("run"):
			velocity = dir * run_vel * delta * 100
		else:
			velocity = dir * vel * delta * 50
	else:
		state = States.Idle
		velocity = Vector2.ZERO
	
	handle_anim()
	move_and_slide()
	
	PlayerDat.pos = global_position

func handle_anim():
	match state:
		States.Idle:
			tex.play("idle")
			tex.flip_h = false
		States.Walk:
			if round(dir.y) == -1:
				tex.play("walk_up")
			elif round(dir.y) == 1:
				tex.play("walk_down")
			elif round(dir.x) == 1:
				tex.play("walk_sideway")
				tex.flip_h = false
			else:
				tex.play("walk_sideway")
				tex.flip_h = true
		_:
			print("how'd you even get this q_q")
		
