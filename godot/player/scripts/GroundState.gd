extends State_State_Machine

@export var air_state : State_State_Machine 

@onready var buffer_timer : Timer = $BufferTimer
@onready var slide_cooldown : Timer = $Slide_Cooldown
@onready var idle : State = $idle
@onready var move : State = $move
@onready var attack : State = $attack
@onready var slide_state : State = $slide
@onready var crouch_state : State = $crouch
@onready var dash_state : State = $dash


func on_enter():
	if !air_state.jump_buffer_timer.is_stopped():
		jump()


func _ready():
	slide_cooldown.wait_time = character.slide_cooldown


# ground state
func state_process(_delta):
	current_state_process(_delta)
	current_state_methods(_delta)
	
	if !character.is_on_floor() && buffer_timer.is_stopped():
		next_state = air_state
	
	if Input.is_action_pressed("crouch") && currentState != slide_state && currentState != crouch_state && slide_cooldown.is_stopped():
		if character.velocity != Vector2.ZERO:
			slide()
		else:
			crouch()

func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		jump()

	if event.is_action_pressed("dash"):
		dash()


func jump():
	character.velocity.y = character.jump_velocity


func crouch():
	currentState.next_state = crouch_state


func slide():
	currentState.next_state = slide_state


func dash():
	currentState.next_state = dash_state
