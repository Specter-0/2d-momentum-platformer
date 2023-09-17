extends Node2D

@onready var character : Player = $player
@onready var grapple_point = $grapple_point
@onready var line : Line2D = $Line2D

func _process(_delta):
	line.points[0] = character.position
	line.points[1] = grapple_point.position
