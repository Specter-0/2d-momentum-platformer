extends State_State_Machine

@export var air_state : State_State_Machine
@export var ground_state : State_State_Machine
@export var quick_jump_buffer : float = 0.1
@export var wall_jump_buffer_time : float = 0.25

@onready var hang : State = $hang
@onready var wall_jump : State = $wall_jump

@onready var wall_jump_buffer_timer : Timer = $Wall_Jump_buffer
@onready var quick_jump : Timer = $Quick_jump

var carryover_velocity : Vector2


func _ready():
	wall_jump_buffer_timer.wait_time = wall_jump_buffer_time
	quick_jump.wait_time = quick_jump_buffer


func on_enter():
	carryover_velocity = character.previous_velocities[-3]
	quick_jump.start()
	
	if !wall_jump_buffer_timer.is_stopped():
		jump()
	
	currentState.next_state = hang


func state_process(_delta): 
	current_state_process(_delta)
	current_state_methods(_delta)

	if character.is_on_floor():
		next_state = ground_state


func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		jump()


func jump():
	currentState.next_state = wall_jump


func on_wall():
	if character.left_cast.is_colliding() || character.right_cast.is_colliding():
		return true
	return false
