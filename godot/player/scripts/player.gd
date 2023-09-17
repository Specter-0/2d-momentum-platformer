extends CharacterBody2D

class_name Player

@export_group("movementt")
@export var speed : Vector2 # combination of max x speed and y speed that can be reached with normal movement : idfk
@export var acceleration : float # how fast you acceleration to speed : seconds
@export var ground_deacceleration : float # how fast you deacceleration to 0 while on the ground : seconds
@export var air_deacceleration : float # how fast you deacceleration to 0 while in the air : seconds
@export_group("jumpp")
@export var jump_velocity : float # size of a from ground jump : idfk
@export var double_jump_velocity : float # size of a from air jump : idfk
@export var amount_of_double_jumps : int # amount of air jumps : iterable
@export_subgroup("boost_jumpp") # happens if you double jump right after a jump, exists to not punish a spam double jump
@export var boost_jump_strenght : float = 1 # strength of the boost jump, standard 1 : multiple
@export var boost_jump_cutoff : float # the cutoff when a normal double jump will be preformed : idfk
@export_group("dashh")
@export var dash_range : Vector2 # speed of dash : idfk
@export var dash_time : float # how long it takes for the dash to deaccelerate : seconds
@export var dash_charge_time : float # cooldown after a dash : seconds
@export_group("slidee")
@export var slide_speed_boost : float # how much sliding increses your speed : multiple
@export var slide_deacceleration : float # the reduced rate of normal ground deacceleration : multiple
@export var slide_exit_hinder : float # how much your speed decreses by when you leave a slide : idfk
@export var slide_exit_jump_boost_strenght : float # how powerfull a slide jump is, higher the number, lower the power : dividend
@export var slide_exit_max_jump_boost : float # highest value that can be reached by a slide jump 
@export var slide_cooldown : float # wait time after leaving a slide : seconds
@export_group("walll")
@export var wall_jump_speed : Vector2 # power in x, y of a wall jump : idfk
@export var wall_carryover_velocity_depletion : float = 3 # dividend of previus velocity before hitting a wall : dividend
@export var wall_sliding : bool = false # toggles wall sliding : T/F
@export var wall_slide_wait : float # how much time you will hang before you slide : seconds
@export var wall_slide_speed : float # max wall sliding speed after acceleration : idfk
@export_subgroup("accelerationn")
@export var wall_slide_acceleration : float # how long it takes to accelerate to max speed in a wall slide : seconds
@export var wall_hang_deacceleration : float # how fast you deaccelerate in y after landing on a wall : seconds
@export var wall_hang_deacceleration_speed : float # tbh i don't remomber wha this does : prob idfk
@export_group("attackk")
@export var base_damage : float # damage an unmodifed and unupgraded attack does : hp

@onready var left_cast : RayCast2D = $LeftCast
@onready var right_cast : RayCast2D = $RightCast
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : BaseCharacterStateMachine = $BaseCharacterStateMachine
@onready var collision_shape : CollisionShape2D = $CollisionShape2D
@onready var dash_cooldown : Timer = $Dash_Cooldown

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var grapple_point : Grappling_Point
var previous_velocities : Array[Vector2]
var true_direction : int = 1

var normal_collision_shape = [preload("res://player/collisionShapes/normal_shape.tres"), Vector2(0, 0)]
var croutch_collision_shape = [preload("res://player/collisionShapes/croutch_shape.tres"), Vector2(0, 4)]
var wallhang_collision_shape = [preload("res://player/collisionShapes/wallhang_shape.tres"), Vector2(-12, 0)]
var dash_collision_shape = [preload("res://player/collisionShapes/dash_shape.tres"), Vector2(0, 0)]


func _ready():
	dash_cooldown.wait_time = dash_charge_time


func _input(event):
	if event.is_action_pressed("left"):
		true_direction = -1
	
	elif event.is_action_pressed("right"):
		true_direction = 1


func _physics_process(delta):
	previous_velocities.append(velocity)
	if previous_velocities.size() > 10:
		previous_velocities = previous_velocities.slice(-10)
	move_and_slide()















