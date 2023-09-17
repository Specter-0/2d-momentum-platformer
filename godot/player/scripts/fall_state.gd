extends State

@export var air_state : State_State_Machine

func state_process(_delta):
	if character.velocity.y <= 0:
		next_state = air_state.climb


func on_enter():
	character.collision_shape.shape = character.normal_collision_shape[0]
	character.collision_shape.position = character.normal_collision_shape[1]
