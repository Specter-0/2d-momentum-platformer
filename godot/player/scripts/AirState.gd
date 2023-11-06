extends State_State_Machine

@export var ground_state : State_State_Machine
@export var wall_state : State_State_Machine
@export var maxed_interval : Vector2 = Vector2(-40, 80)
@export var jump_buffer_time : float = 0.1
@export var coyote_time : float = 0.1


@onready var jump_buffer_timer : Timer = $Jump_buffer
@onready var coyote_timer : Timer = $Coyote_time
@onready var peak : State = $peak
@onready var climb : State = $climb
@onready var fall : State = $fall

var has_double_jumped : bool = false
var double_jump_count : int = 1


func _ready():
	jump_buffer_timer.wait_time = jump_buffer_time
	coyote_timer.wait_time = coyote_time


func on_enter():
	coyote_timer.start()


func state_process(_delta):
	current_state_process(_delta)
	current_state_methods(_delta)
	
	if character.is_on_floor():
		has_double_jumped = false
		next_state = ground_state
	
	wall_raycast()


func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		jump()


func wall_raycast():
	if character.left_cast.is_colliding() || character.right_cast.is_colliding():
		has_double_jumped = false
		next_state = wall_state


func jump():
	if !coyote_timer.is_stopped():
		coyote_jump()
		
	elif !has_double_jumped:
		double_jump()
		
	else:
		jump_buffer_timer.start()


func coyote_jump():
	character.velocity.y = character.jump_velocity


func double_jump():
	character.velocity.y = character.double_jump_velocity
	
	if character.amount_of_double_jumps == double_jump_count && character.amount_of_double_jumps != -1:
		has_double_jumped = true
		double_jump_count = 1
	else:
		double_jump_count += 1
