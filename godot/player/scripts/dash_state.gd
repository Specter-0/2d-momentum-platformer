extends State

@export var ground_state : State_State_Machine 

func on_enter():
	#ground_state.buffer_timer.start()
	if character.dash_cooldown.is_stopped():
		dash()


func state_process(_delta):
	if dash_is_done():
		next_state = ground_state.move
	elif character.velocity == Vector2.ZERO:
		next_state = ground_state.idle
	
	dash_deaccelration(_delta)
