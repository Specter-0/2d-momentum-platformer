extends State

@export var ground_state : State_State_Machine

func on_enter():
	character.velocity.x = character.velocity.x * character.slide_speed_boost


func state_process(_delta):
	character.velocity.x -= _delta / (character.ground_deacceleration * character.slide_deacceleration) * character.velocity.x 
	
	if !Input.is_action_pressed("crouch"):
		next_state = ground_state.move
	

	if character.velocity.y != 0:
		character.velocity.y += clamp(abs(character.velocity.x) / -character.slide_exit_jump_boost_strenght, character.slide_exit_max_jump_boost, 0)

func on_exit():
	character.velocity.x += character.slide_exit_hinder * sign(character.velocity.x)
	ground_state.slide_cooldown.start()
