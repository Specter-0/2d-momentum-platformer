extends State_State_Machine

@export var air_state : State_State_Machine
@export var ground_state : State_State_Machine
@export var quick_jump_buffer : float = 0.1
@export var wall_jump_buffer_time : float = 0.25

@onready var wall_dash : State = $wall_dash
@onready var wall_slide : State = $wall_slide
@onready var hang : State = $hang
@onready var wall_jump : State = $wall_jump

@onready var wall_jump_buffer_timer : Timer = $Wall_Jump_buffer
@onready var quick_jump : Timer = $Quick_jump
@onready var to_slide : Timer = $To_slide

var carryover_velocity : Vector2


func _ready():
	wall_jump_buffer_timer.wait_time = wall_jump_buffer_time
	to_slide.wait_time = character.wall_slide_wait
	quick_jump.wait_time = quick_jump_buffer


func on_enter():
	carryover_velocity = character.previous_velocities[-3]
	quick_jump.start()
	
	if !wall_jump_buffer_timer.is_stopped():
		jump()
	
	currentState.next_state = hang
	
	if character.wall_sliding:
		to_slide.start()


func state_process(_delta): 
	current_state_process(_delta)
	current_state_methods(_delta)

	if character.is_on_floor():
		next_state = ground_state

func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		jump()
	
	if event.is_action_pressed("dash"):
		dash_check()
	
	if event.is_action_pressed("crouch"):
		crouch()
	

func jump():
	currentState.next_state = wall_jump
	

func dash_check():
	if direction().x == -1 && character.right_cast.is_colliding():
		dash()
	elif direction().x == 1 && character.left_cast.is_colliding():
		dash()


func dash():
	currentState.next_state = wall_dash


func crouch():
	if character.left_cast.is_colliding:
		character.velocity.x = -character.speed.x
	else:
		character.velocity.x = character.speed.x


func _on_to_slide_timeout():
	currentState.next_state = wall_slide


func on_wall():
	if character.left_cast.is_colliding() || character.right_cast.is_colliding():
		return true
	return false
