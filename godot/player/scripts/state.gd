extends Node

class_name State

@export var character : Player 
@export var line2d : Line2D
@export var standard_movement : bool = true
@export var can_move : bool = true 
@export var Gravity : bool = true

var next_state : State 
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var dash_direction : Vector2

func state_process(_delta):
	pass


func state_methods(_delta):
	if not character.is_on_floor() && Gravity:
		character.velocity.y += gravity * _delta
		
	if standard_movement:
		var prv_vel : float = character.velocity.x
		if direction().x != 0 && character.state_machine.check_if_can_move() && abs(character.velocity.x) <= character.speed.x:
			character.velocity.x += _delta / character.acceleration * character.speed.x * direction().x
		else:
			if character.is_on_floor():
				character.velocity.x -= _delta / character.ground_deacceleration * character.speed.x * sign(character.velocity.x)
			else:
				character.velocity.x -= _delta / character.air_deacceleration * character.speed.x * sign(character.velocity.x)
				if direction().x != sign(character.velocity.x) && direction().x != 0:
					character.velocity.x -= _delta / character.ground_deacceleration * character.speed.x * sign(character.velocity.x)
		
			if sign(prv_vel) != sign(character.velocity.x):
				character.velocity.x = 0


func state_input(_event : InputEvent):
	pass


func on_enter():
	pass


func on_exit():
	pass


func direction():
	return Input.get_vector("left", "right", "up", "down")
