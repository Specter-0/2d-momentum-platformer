extends State

@export var wall_state : State_State_Machine

func on_enter():
	var jump_direction = -1
	if character.left_cast.is_colliding():
		jump_direction = 1
	
	character.velocity = Vector2(character.wall_jump_speed.x * jump_direction, character.wall_jump_speed.y)
	
	if !wall_state.quick_jump.is_stopped():
		character.velocity += (abs(wall_state.carryover_velocity) / character.wall_carryover_velocity_depletion) * jump_direction
	wall_state.next_state = wall_state.air_state
