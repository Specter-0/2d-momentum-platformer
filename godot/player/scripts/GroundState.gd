extends State_State_Machine

@export var air_state : State_State_Machine 

@onready var buffer_timer : Timer = $BufferTimer
@onready var idle : State = $idle
@onready var move : State = $move
@onready var attack : State = $attack


func on_enter():
	if !air_state.jump_buffer_timer.is_stopped():
		jump()


# ground state
func state_process(_delta):
	current_state_process(_delta)
	current_state_methods(_delta)
	
	if !character.is_on_floor() && buffer_timer.is_stopped():
		next_state = air_state

func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		jump()


func jump():
	character.velocity.y = character.jump_velocity


