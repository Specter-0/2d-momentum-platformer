extends State

@export var ground_state : State_State_Machine 

func state_process(_delta):
	if character.velocity.x != 0:
		next_state = ground_state.move


func on_enter():
	character.collision_shape.shape = character.normal_collision_shape[0]
	character.collision_shape.position = character.normal_collision_shape[1]
