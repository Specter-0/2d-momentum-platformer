extends State

@export var air_state : State_State_Machine 

@onready var cooldown : Timer = $Cooldown


func on_enter():
	if cooldown.is_stopped():
		character.collision_shape.shape = character.wallhang_collision_shape[0]
		character.collision_shape.position = character.wallhang_collision_shape[1]
		character.velocity = Vector2.ZERO
		
		#if character.raycasts[0].is_colliding:
		#	character.flip(left)
		#else:
		#	character.flip(right)
	else:
		next_state = air_state.fall


func state_input(event):
	if event.is_action_pressed("jump"):
		cooldown.start()
		next_state = air_state.wall_jump
	
	if event.is_action_pressed("crouch"):
		next_state = air_state.fall
		if character.raycasts[0].is_colliding:
			character.velocity.x = -character.speed
		else:
			character.velocity.x = character.speed
		cooldown.start()
