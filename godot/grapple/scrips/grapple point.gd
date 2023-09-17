extends Area2D

class_name Grappling_Point

@export var character : Player
@export var reopen_time : float = 5

@onready var reopen_timer : Timer = $Reopen
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D


func _ready():
	reopen_timer.wait_time = reopen_time


func _on_animated_sprite_2d_animation_finished():
	reopen_timer.start()


func _on_reopen_timeout():
	animated_sprite.play("ready")
