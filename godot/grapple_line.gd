extends Line2D

@export var character : Player


func _process(_delta):
	if Input.is_action_pressed("grapple"):
		visible = true
	else:
		visible = false
	
	points[0] = character.position
	points[1] = character.grapple_point.position

	
