extends State

@export var wall_state : State_State_Machine

func on_enter():
	if character.velocity == Vector2.ZERO:
		next_state = wall_state.hang

func state_process(_delta):
	if !character.left_cast.is_colliding() && !character.right_cast.is_colliding():
		wall_state.next_state = wall_state.air_state
		return
	
	character.velocity.y += _delta / character.wall_slide_acceleration * character.wall_slide_speed 
	character.velocity.y = clamp(character.velocity.y, 0, character.wall_slide_speed)
