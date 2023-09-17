extends State

@export var wall_state : State_State_Machine
@export var clamp_hang_sliding_speed : bool = true
@export var max_hang_sliding_speed : float

func on_exit():
	pass


func state_process(_delta):
	if !wall_state.on_wall():
		wall_state.next_state = wall_state.air_state
	
	var prv_vel : float = character.velocity.y
	if character.velocity.y != 0:
		
		if character.velocity.y > 0:
			character.velocity.y -= _delta / character.wall_hang_deacceleration * character.wall_hang_deacceleration_speed * sign(character.velocity.y)
		else:
			character.velocity.y -= _delta / character.wall_hang_deacceleration * character.wall_hang_deacceleration_speed / 2 * sign(character.velocity.y)
		if sign(prv_vel) != sign(character.velocity.y):
			character.velocity.y = 0
	
	if clamp_hang_sliding_speed:
		character.velocity.y = clamp(character.velocity.y, -max_hang_sliding_speed, max_hang_sliding_speed) # replace with a variable plz
